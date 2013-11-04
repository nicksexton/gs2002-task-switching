% Simulation of individual differences in a population of models
% 
% Based on individual differences data, individual scores for task switching
% should correlate across tasks, but should not correlate with task switching scores
% ie. switch costs should NOT correlate with RTi - RT-c


close all;
clear all;
initglobals



SUBJECTS = 3;
NOISE_TASKDEMAND = 1;   % controls SD of gaussian noise added to task demand 
                        % weights individually for each subject
data_allsubs_colour_neutral = [];
data_allsubs_colour_congruent = [];
data_allsubs_colour_incongruent = [];
            
                        
% initstimuli 
FIXED_BLOCKLENGTH = 100; % number of fixed block trials
FIXED_RUNS = FIXED_BLOCKLENGTH; % needs to be equal to BLOCKLENGTH
MIXED_BLOCKLENGTH = 12; % needs to be 12 for mixed trials
MIXED_RUNS = 4; % needs to be 4 for mixed trials
BLOCKS = 100; % number of mixed block trials

% stimuli_fixed_word = stimblock_create (FIXED_BLOCKLENGTH, 1, FIXED_RUNS);
stimuli_fixed_colour = stimblock_create (FIXED_BLOCKLENGTH, 2, FIXED_RUNS);


allsubs_IV_DV = [];

% Loop - simulates 10 different subjects
% NEW - PARALLEL LOOP
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



%% Analyse the data    

    word_congruent = [];
    word_incongruent = [];
    word_neutral = [];

    colour_congruent = [];
    colour_incongruent = [];
    colour_neutral = [];
    
    colour_congruent_error = [];
    colour_incongruent_error = [];
    colour_neutral_error = [];

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
      if output(trial, 2) == 0
        colour_neutral_error = [colour_neutral; output(trial,:)];
      else 
        colour_neutral = [colour_neutral; output(trial,:)];
      end

    elseif (stimuli_fixed_colour(trial,3) == 1)
      if output(trial, 2) == 0
        colour_congruent_error = [colour_congruent; output(trial,:)];
      else
        colour_congruent = [colour_congruent; output(trial,:)]; 
      end
            
    elseif (stimuli_fixed_colour(trial,3) == 2)
      if output(trial, 2) == 0
        colour_incongruent_error = [colour_incongruent; output(trial,:)];
      else
        colour_incongruent = [colour_incongruent; output(trial,:)];
      end

    end

  end

DV_response_inhibition = mean(colour_incongruent(:,3)) -...
                         mean(colour_congruent(:,3));

    if (size(colour_incongruent_error, 1) > 0) && ...
            (size(colour_congruent_error, 1) > 0)
        
        DV_response_inhibition_error = ...
            mean(colour_incongruent_error(:,3)) - mean(colour_congruent_error(:,3));
    else
        DV_response_inhibition_error = [];
    end
                           
fprintf ('\tRTi-RTc: %4.2f (err: %4.2f)\n', ...
        DV_response_inhibition, DV_response_inhibition_error);

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
        for i = 1:size(output,1)
            if output(i,2) == 1    
                allblocks_RTs(block,:) = output(:,3)';
            else
                allblocks_RTs_errors(block,:) = output(:,3)';
            end
        end
    end

    output_mixed = output;
  
    %fprintf ('\n');

    mean_RT = mean(allblocks_RTs);
    mean_RT_errors = mean(allblocks_RTs_errors);
    sd_RT = std(allblocks_RTs);
    sd_RT_errors = std(allblocks_RTs_errors);

       
    DV_switchcost_wordcolour = (mean_RT(5) - sum(mean_RT(6:8)) / 3);
    DV_switchcost_colourword = (mean_RT(9) - sum(mean_RT(10:12)) / 3);
    
    DV_switchcost_wordcolour_errors = (mean_RT_errors(5) - sum(mean_RT_errors(6:8)) / 3);
    DV_switchcost_colourword_errors = (mean_RT_errors(9) - sum(mean_RT_errors(10:12)) / 3);

    

%% Update allsubjects data
    % also put this in a matrix to plot scatter graphs of all subjects
    allsubs_IV_DV = [allsubs_IV_DV; ...
            IV_parameter DV_response_inhibition DV_response_inhibition_error ... 
                DV_switchcost_wordcolour DV_switchcost_colourword ...
                DV_switchcost_wordcolour_errors DV_switchcost_colourword_errors];

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
    scatter (allsubs_IV_DV(:,1), allsubs_IV_DV(:,2), 'b');
    hold on;
    scatter (allsubs_IV_DV(:,1), allsubs_IV_DV(:,3), 'r');
    title ('Scatter plot of IV vs RI score (RTi - RTc)')
    xlabel ('TD unit inhibition of output units');
    ylabel ('Response Inhibition score (RTi - RTc)');
    
    %% calculate correlations coefficients between IV and DVs
    correlation_IV_RI = corrcoef (allsubs_IV_DV(:,1), allsubs_IV_DV(:,2));
    correlation_IV_TSwc = corrcoef (allsubs_IV_DV(:,1), allsubs_IV_DV(:,4));
    correlation_IV_TScw = corrcoef (allsubs_IV_DV(:,1), allsubs_IV_DV(:,5));
    correlation_RI_TSwc = corrcoef (allsubs_IV_DV(:,2), allsubs_IV_DV(:,4));
    correlation_RI_TScw = corrcoef (allsubs_IV_DV(:,2), allsubs_IV_DV(:,5));
    correlation_TSwc_TScw = corrcoef (allsubs_IV_DV(:,4), allsubs_IV_DV(:,5));
    
    fprintf ('correlations (correct trials):\n');
    fprintf ('IV with RI: R = %4.3f\n', correlation_IV_RI(1,2));
    fprintf ('IV with TSwc: R = %4.3f\n', correlation_IV_TSwc(1,2));
    fprintf ('IV with TScw: R = %4.3f\n', correlation_IV_TScw(1,2));
    fprintf ('RI with TSwc: R = %4.3f\n', correlation_RI_TSwc(1,2));
    fprintf ('RI with TScw: R = %4.3f\n', correlation_RI_TScw(1,2));
    fprintf ('TSwc with TScw: R = %4.3f\n', correlation_TSwc_TScw(1,2));
    
    
    %% Plot graphs
    % plot scatter graph of varying IV parameter vs. DV (switch cost)
    figure (5);
    title ('Scatter plot of IV vs switch cost (word->colour)')
    scatter (allsubs_IV_DV(:,1), allsubs_IV_DV(:,4), 'b'); % correct trials
    hold on;
    scatter (allsubs_IV_DV(:,1), allsubs_IV_DV(:,6), 'r'); % errors
    xlabel ('TD unit inhibition of output units');
    ylabel ('Switch cost (word -> colour)');
    
    figure (6);
    title ('Scatter plot of IV vs switch cost (colour->word)')
    scatter (allsubs_IV_DV(:,1), allsubs_IV_DV(:,5), 'b'); % correct trials
    hold on;
    scatter (allsubs_IV_DV(:,1), allsubs_IV_DV(:,7), 'r'); % errors
    xlabel ('TD unit inhibition of output units');
    ylabel ('Switch cost (colour -> word)');
    
    % now scatter graph of RI vs. TSC
    figure (7);
    title ('Scatter plot of Response Inhibition (correct trials) vs Task Switch Cost (word->colour)')
    scatter (allsubs_IV_DV(:,2), allsubs_IV_DV(:,4), 'b'); % correct trials
    scatter (allsubs_IV_DV(:,2), allsubs_IV_DV(:,6), 'r'); % error trials
    hold on;
    xlabel ('Response Inhibition (RTi - RTc)/cycles');
    ylabel ('Switch cost (word -> colour)');
    
    figure (8);
    title ('Scatter plot of Response Inhbition (correct trials) vs Task Switch Cost (colour->word)')
    scatter (allsubs_IV_DV(:,2), allsubs_IV_DV(:,5), 'b'); % correct
    scatter (allsubs_IV_DV(:,2), allsubs_IV_DV(:,7), 'r'); % error
    hold on;
    xlabel ('Response Inhibition (RTi - RTc)/cycles');
    ylabel ('Switch cost (colour -> word)');