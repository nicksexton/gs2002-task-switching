% Simulation of individual differences in a population of models
% 
% HYPOTHESIS - individual differences in Stroop ('response inhibition') can
% be simulated by adding noise to connection weights 
% a) from task demand -> output units  b) bottom-up connections from input
% to output units


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
BLOCKLENGTH = 100;
RUNS = 100;

stimuli_fixed_word = stimblock_create (BLOCKLENGTH, 1, RUNS);
stimuli_fixed_colour = stimblock_create (BLOCKLENGTH, 2, RUNS);


allsubs_IV_DV = [];

% Loop - simulates 10 different subjects
for subject = 1:SUBJECTS

    %% Set individually varying parameters
    
    vary_parameters;
    % note vary_parameters script should update IV_parameter

    %% run simulations

    % STIM_THIS_BLOCK = stimuli_fixed_word;
    % run_block;
    % output_fixed_word = output;

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



  for trial = 1:BLOCKLENGTH


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
  
    % also put this in a matrix to plot scatter graphs of all subjects
    allsubs_IV_DV = [allsubs_IV_DV; ...
            IV_parameter DV_response_inhibition];

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
    
    %%
    r = corrcoef (allsubs_IV_DV(:,1), allsubs_IV_DV(:,2));
    fprintf ('R = %4.3f\n', r(1,2));