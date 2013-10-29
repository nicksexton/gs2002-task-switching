% Simulation of individual differences in a population of models
% 
% Based on individual differences data, individual scores for task switching
% should correlate across tasks, but should not correlate with task switching scores
% ie. switch costs should NOT correlate with RTi - RT-c


close all;
clear all;
initglobals



SUBJECTS = 100;
NOISE_TASKDEMAND = 1;   % controls SD of gaussian noise added to task demand 
                        % weights individually for each subject
data_allsubs_colour_neutral = [];
data_allsubs_colour_congruent = [];
data_allsubs_colour_incongruent = [];
            
                        
% initstimuli 
FIXED_BLOCKLENGTH = 50;
FIXED_RUNS = 50;
MIXED_BLOCKLENGTH = 12;
MIXED_RUNS = 4;
BLOCKS = 30;

% stimuli_fixed_word = stimblock_create (FIXED_BLOCKLENGTH, 1, FIXED_RUNS);
stimuli_fixed_colour = stimblock_create (FIXED_BLOCKLENGTH, 2, FIXED_RUNS);


allsubs_IV_DV = [];

% Loop - simulates 10 different subjects
for subject = 1:SUBJECTS
    
    initmodel;    
    
    %% Set individually varying parameters
    
    vary_parameters;
    % note vary_parameters script should update IV_parameter

    %% run simulations

    % STIM_THIS_BLOCK = stimuli_fixed_word;
    % run_block;
    % output_fixed_word = output;

    BLOCKLENGTH = FIXED_BLOCKLENGTH;
    STIM_THIS_BLOCK = stimuli_fixed_colour;
    run_block;
    output_fixed_colour = output;



%% Analyse the data    

    word_congruent = [];
    word_incongruent = [];
    word_neutral = [];

    colour_congruent = [];
    colour_incongruent = [];
    colour_neutral = [];


  for trial = 1:FIXED_BLOCKLENGTH


  % split word reading blocks into stimulus type
  %  if (stimuli_fixed_word(trial,3) == 0)
  %    word_neutral = [word_neutral; output_fixed_word(trial,:)];

  %  elseif (stimuli_fixed_word(trial,3) == 1)
  %    word_congruent =[word_congruent; output_fixed_word(trial,:)];

  %  elseif (stimuli_fixed_word(trial,3) == 2)
  %    word_incongruent = [word_incongruent; output_fixed_word(trial,:)];

  %  end

  % split colour naming blocks into stimulus type
    if (stimuli_fixed_colour(trial,3) == 0)
      colour_neutral = [colour_neutral; output_fixed_colour(trial,:)];

    elseif (stimuli_fixed_colour(trial,3) == 1)
      colour_congruent = [colour_congruent; output_fixed_colour(trial,:)];

    elseif (stimuli_fixed_colour(trial,3) == 2)
      colour_incongruent = [colour_incongruent; output_fixed_colour(trial,:)];

    end

  end

DV_response_inhibition = mean(colour_incongruent(:,3)) - mean(colour_congruent(:,3));
fprintf ('\tRTi-RTc: %4.2f\n', DV_response_inhibition);

%% Now run mixed blocks simulation


    BLOCKLENGTH = MIXED_BLOCKLENGTH;
 
    
    stimuli_mixed = [];

    %init identical stimuli (?)
    for trial = 1:MIXED_BLOCKLENGTH
        stimuli_mixed = [stimuli_mixed; 1 2 2 1+mod(floor((trial-1)/MIXED_RUNS), 2)]; 
    end

    % run simulations

    STIM_THIS_BLOCK = stimuli_mixed;

    for block = 1:BLOCKS

        % fprintf('\nSubject %d of %d: ', block, BLOCKS);
        run_block;
        allblocks_RTs(block,:) = output(:,3)';
        %allblocks_errors(subject,:) = output(:,2)';
    
    end

    output_mixed = output;
  
    fprintf ('\n');

    mean_RT = mean(allblocks_RTs);
    sd_RT = std(allblocks_RTs);

    % error_rate = mean(allblocks_errors);

    
    DV_switchcost_wordcolour = (mean_RT(5) - sum(mean_RT(6:8)) / 3);
    DV_switchcost_colourword = (mean_RT(9) - sum(mean_RT(10:12)) / 3);
    

    

%% Update allsubjects data
    % also put this in a matrix to plot scatter graphs of all subjects
    allsubs_IV_DV = [allsubs_IV_DV; ...
            IV_parameter DV_response_inhibition ... 
                DV_switchcost_wordcolour DV_switchcost_colourword];

  %% aggregate data from all subjects
  
  % colour naming only for now
  data_allsubs_colour_neutral = [data_allsubs_colour_neutral; ...
         [colour_neutral(:,3) linspace(subject,subject, size(colour_neutral,1))']
         ];
     
  data_allsubs_colour_congruent = [data_allsubs_colour_congruent; ...
         [colour_congruent(:,3) linspace(subject,subject, size(colour_congruent,1))']
         ];
         
  data_allsubs_colour_incongruent = [data_allsubs_colour_incongruent; ...
         [colour_incongruent(:,3) linspace(subject,subject, size(colour_incongruent,1))']
         ];


     
end

    
    %% Boxplots
    % Neutral trials
    figure (1);
    boxplot (data_allsubs_colour_neutral(:,1), data_allsubs_colour_neutral(:,2));
    hold on;
    set (gca, 'XTick', 1:1:SUBJECTS)
    set (gca, 'XTickLabel', 1:1:SUBJECTS);
    ylim ([0 400]);
    title ('Boxplot of Reaction Times for colour naming: neutral trials');
    
    %Congruent trials
    figure (2);   
    boxplot (data_allsubs_colour_congruent(:,1), data_allsubs_colour_congruent(:,2));
    hold on;
    set (gca, 'XTick', 1:1:SUBJECTS)
    set (gca, 'XTickLabel', 1:1:SUBJECTS);
    ylim ([0 400]);
    title ('Boxplot of Reaction Times for colour naming: congruent trials');
    
    figure (3);
    boxplot (data_allsubs_colour_incongruent(:,1), data_allsubs_colour_incongruent(:,2));
    hold on;
    set (gca, 'XTick', 1:1:SUBJECTS)
    set (gca, 'XTickLabel', 1:1:SUBJECTS);
    ylim ([0 400]);
    title ('Boxplot of Reaction Times for colour naming: incongruent trials');
    

    % plot scatter graph of varying parameter vs. DV (RTi - RTc)
    figure (4);
    scatter (allsubs_IV_DV(:,1), allsubs_IV_DV(:,2));
    hold on;
    xlabel ('TD unit inhibition of output units');
    ylabel ('Response Inhibition score (RTi - RTc)');
    
    %% calculate correlations coefficients between IV and DVs
    correlation_IV_RI = corrcoef (allsubs_IV_DV(:,1), allsubs_IV_DV(:,2));
    correlation_IV_TSwc = corrcoef (allsubs_IV_DV(:,1), allsubs_IV_DV(:,3));
    correlation_IV_TScw = corrcoef (allsubs_IV_DV(:,1), allsubs_IV_DV(:,4));
    correlation_RI_TSwc = corrcoef (allsubs_IV_DV(:,2), allsubs_IV_DV(:,3));
    correlation_RI_TScw = corrcoef (allsubs_IV_DV(:,2), allsubs_IV_DV(:,4));
    
    fprintf ('correlations:\n');
    fprintf ('IV with RI: R = %4.3f\n', correlation_IV_RI(1,2));
    fprintf ('IV with TSwc: R = %4.3f\n', correlation_IV_TSwc(1,2));
    fprintf ('IV with TScw: R = %4.3f\n', correlation_IV_TScw(1,2));
    fprintf ('RI with TSwc: R = %4.3f\n', correlation_RI_TSwc(1,2));
    fprintf ('RI with TScw: R = %4.3f\n', correlation_RI_TScw(1,2));
    
    
    %% Plot graphs
    % plot scatter graph of varying IV parameter vs. DV (switch cost)
    figure (5);
    scatter (allsubs_IV_DV(:,1), allsubs_IV_DV(:,3));
    hold on;
    xlabel ('TD unit inhibition of output units');
    ylabel ('Switch cost (word -> colour)');
    
    figure (6);
    scatter (allsubs_IV_DV(:,1), allsubs_IV_DV(:,4));
    hold on;
    xlabel ('TD unit inhibition of output units');
    ylabel ('Switch cost (colour -> word)');
    
    % now scatter graph of RI vs. TSC
    figure (7);
    scatter (allsubs_IV_DV(:,2), allsubs_IV_DV(:,3));
    hold on;
    xlabel ('Response Inhibition (RTi - RTc)/cycles');
    ylabel ('Switch cost (word -> colour)');
    
    figure (8);
    scatter (allsubs_IV_DV(:,2), allsubs_IV_DV(:,4));
    hold on;
    xlabel ('Response Inhibition (RTi - RTc)/cycles');
    ylabel ('Switch cost (colour -> word)');