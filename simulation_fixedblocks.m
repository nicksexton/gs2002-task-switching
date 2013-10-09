# analysis of model performance on fixed blocks
# corresponds to Shallice & Gilbert 2002 p.311
# main empirical effect: Stroop interference and facilitation
# on congruent, incongruent and neutral trials

close all;
clear all;
initglobals
# initstimuli 

BLOCKLENGTH = 100;
RUNS = 100;

stimuli_fixed_word = stimblock_create (BLOCKLENGTH, 1, RUNS);
stimuli_fixed_colour = stimblock_create (BLOCKLENGTH, 2, RUNS);

# run simulations

STIM_THIS_BLOCK = stimuli_fixed_word;
run_block;
output_fixed_word = output;

STIM_THIS_BLOCK = stimuli_fixed_colour;
run_block;
output_fixed_colour = output;


# now plot the data

word_congruent = [];
word_incongruent = [];
word_neutral = [];

colour_congruent = [];
colour_incongruent = [];
colour_neutral = [];

for trial = 1:BLOCKLENGTH


# split word reading blocks into stimulus type
  if (stimuli_fixed_word(trial,3) == 0)
    word_neutral = [word_neutral; output_fixed_word(trial,:)];

  elseif (stimuli_fixed_word(trial,3) == 1)
    word_congruent =[word_congruent; output_fixed_word(trial,:)];

  elseif (stimuli_fixed_word(trial,3) == 2)
    word_incongruent = [word_incongruent; output_fixed_word(trial,:)];

  end

# split colour naming blocks into stimulus type
  if (stimuli_fixed_colour(trial,3) == 0)
    colour_neutral = [colour_neutral; output_fixed_colour(trial,:)];

  elseif (stimuli_fixed_colour(trial,3) == 1)
    colour_congruent = [colour_congruent; output_fixed_colour(trial,:)];

  elseif (stimuli_fixed_colour(trial,3) == 2)
    colour_incongruent = [colour_incongruent; output_fixed_colour(trial,:)];

  end

end

  # RTs for word naming
  mean_RT = [mean(word_neutral(:,3)) mean(word_incongruent(:,3)) \
	     mean(word_congruent(:,3));
	     mean(colour_neutral(:,3)) mean(colour_incongruent(:,3)) \
	      mean(colour_congruent(:,3))]




   # plot graph

   figure (1);
   plot ([1 2 3], mean_RT);
   legend (["word reading"; "colour naming"]);
   set (gca, 'XTick', [1 2 3])
   set (gca, 'XTickLabel', ["neutral"; "incongruent"; "congruent"]);
  hold on;





