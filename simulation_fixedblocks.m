% analysis of model performance on fixed blocks
% corresponds to Shallice & Gilbert 2002 p.311
% main empirical effect: Stroop interference and facilitation
% on congruent, incongruent and neutral trials

close all;
clear all;
initglobals
% initstimuli 

BLOCKLENGTH = 400;
RUNS = 400;

stimuli_fixed_word = stimblock_create (BLOCKLENGTH, 1, RUNS);
stimuli_fixed_colour = stimblock_create (BLOCKLENGTH, 2, RUNS);

% run simulations

STIM_THIS_BLOCK = stimuli_fixed_word;
run_block;
output_fixed_word = output;

STIM_THIS_BLOCK = stimuli_fixed_colour;
run_block;
output_fixed_colour = output;


% now plot the data

word_congruent = [];
word_incongruent = [];
word_neutral = [];

colour_congruent = [];
colour_incongruent = [];
colour_neutral = [];

for trial = 1:BLOCKLENGTH


% split word reading blocks into stimulus type
  if (stimuli_fixed_word(trial,3) == 0)
    word_neutral = [word_neutral; output_fixed_word(trial,:)];

  elseif (stimuli_fixed_word(trial,3) == 1)
    word_congruent =[word_congruent; output_fixed_word(trial,:)];

  elseif (stimuli_fixed_word(trial,3) == 2)
    word_incongruent = [word_incongruent; output_fixed_word(trial,:)];

  end

% split colour naming blocks into stimulus type
  if (stimuli_fixed_colour(trial,3) == 0)
    colour_neutral = [colour_neutral; output_fixed_colour(trial,:)];

  elseif (stimuli_fixed_colour(trial,3) == 1)
    colour_congruent = [colour_congruent; output_fixed_colour(trial,:)];

  elseif (stimuli_fixed_colour(trial,3) == 2)
    colour_incongruent = [colour_incongruent; output_fixed_colour(trial,:)];

  end

end

  % RTs for word naming
  mean_RT = [mean(word_neutral(:,3)) mean(word_incongruent(:,3)) ...
	     mean(word_congruent(:,3)); ...
	     mean(colour_neutral(:,3)) mean(colour_incongruent(:,3)) ...
	     mean(colour_congruent(:,3))]

  sd_RT = [std(word_neutral(:,3)) std(word_incongruent(:,3)) ...
	   std(word_congruent(:,3)); ...
	   std(colour_neutral(:,3)) std(colour_incongruent(:,3)) ...
	   std(colour_congruent(:,3))]


   % plot graph
   % Only interested in colour naming for now
   % NB. Miyake et al. dependent measure for response inhibition in Stroop
   % is mean incongruent - mean neutral for colour naming

   
  figure (1);
  plot ([1 2 3], mean_RT(2,:));
  hold on;
  h1 = errorbar([1 2 3], mean_RT(2,:), sd_RT(2,:));
  %set(h1, 'marker', '+');
  %set(h1, 'linestyle', 'none');

  % legend (['word reading'; 'colour naming']);
  set (gca, 'XTick', [1 2 3])
  set (gca, 'XTickLabel', {'neutral', 'incongruent', 'congruent'});
  axis([0,4,0,200]);
  hold on;
  % print ("stroop.pdf", 'pdf')


    %% let's plot a histogram to see what is going on
    %figure(2);
    %hist (colour_incongruent(:,3), [0:5:400]);
    %title ('Distribution of response times for incongruent colour naming trials');
    %hist_incongruent = findobj(gca, 'Type', 'Patch');
    %set (hist_incongruent, 'FaceColor', [0 .5 .5], 'EdgeColor', [0 .5 .5]);
    %axis ([0 400 0 40]);
    
    %figure (3);
    %hist (colour_neutral(:,3), [0:5:400]);
    %title ('Distribution of response times for neutral colour naming trials');
    %hist_incongruent = findobj(gca, 'Type', 'Patch');
    %set (hist_incongruent, 'FaceColor', [.5 .0 .5], 'EdgeColor', [.5 .0 .5]);
    %axis ([0 400 0 40]);
    
    %% Boxplots
    figure (2);
   
    % create matrix suitable for boxplotting
    colour_data_all = ([ ...
            colour_neutral(:,3) linspace(1,1, size(colour_neutral,1))'; ...
            colour_congruent(:,3) linspace(2,2,size(colour_congruent,1))'; ...
            colour_incongruent(:,3) linspace(3,3,size(colour_incongruent,1))' ...
            ]);
   
    %colour_data_boxplot_positions = [1 2 3];    
    boxplot (colour_data_all(:,1), colour_data_all(:,2));
    hold on;

    set (gca, 'XTick', [1 2 3])
    set (gca, 'XTickLabel', {'neutral', 'congruent', 'incongruent'});
    ylim ([0 400]);
    title ('Boxplot of Reaction Times for colour naming trials');
    

 