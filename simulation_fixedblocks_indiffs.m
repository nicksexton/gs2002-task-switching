% Simulation of individual differences in a population of models
% 
% HYPOTHESIS - individual differences in Stroop ('response inhibition') can
% be simulated by adding noise to connection weights 
% a) from task demand -> output units  b) bottom-up connections from input
% to output units


close all;
clear all;
initglobals



SUBJECTS = 10;
NOISE_TASKDEMAND = 1;   % controls SD of gaussian noise added to task demand 
                        % weights individually for each subject
data_allsubs_colour_neutral = [];
data_allsubs_colour_congruent = [];
data_allsubs_colour_incongruent = [];

                        
                        
% initstimuli 
BLOCKLENGTH = 400;
RUNS = 400;

stimuli_fixed_word = stimblock_create (BLOCKLENGTH, 1, RUNS);
stimuli_fixed_colour = stimblock_create (BLOCKLENGTH, 2, RUNS);


% Loop - simulates 10 different subjects
for subject = 1:SUBJECTS

    taskdemand_pos = 2.5 + NOISE_TASKDEMAND * randn(1);
    taskdemand_neg = -2.5 + NOISE_TASKDEMAND * randn(1);

% Print the subject number to the editor to monitor progress of simulation
fprintf ('SUBJECT:%d\t TD weights %3.2f %3.2f\t', subject, taskdemand_pos, taskdemand_neg)
    
    weights_taskdemand_wordout = ...
        [taskdemand_pos taskdemand_pos taskdemand_pos; ...
         taskdemand_neg taskdemand_neg taskdemand_neg];
    
    weights_taskdemand_colourout = ...
        [taskdemand_neg taskdemand_neg taskdemand_neg; ...
         taskdemand_pos taskdemand_pos taskdemand_pos]; 
     

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
fprintf ('\tRTi-RTc: %4.2f\n', mean(colour_incongruent(:,3)) - mean(colour_congruent(:,3)));
  
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
    

 