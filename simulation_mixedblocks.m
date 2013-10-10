# analysis of model performance on fixed blocks
# corresponds to Shallice & Gilbert 2002 p.311
# main empirical effect: Stroop interference and facilitation
# on congruent, incongruent and neutral trials

close all;
clear all;
initglobals
# initstimuli 

BLOCKLENGTH = 12;
RUNS = 4;
SUBJECTS = 100;

stimuli_mixed = [];

#identical stimuli (?)
for trial = 1:BLOCKLENGTH
  stimuli_mixed = [stimuli_mixed; 1 2 2 1+mod(floor((trial-1)/RUNS), 2)]; 
end

# run simulations

STIM_THIS_BLOCK = stimuli_mixed;

for subject = 1:SUBJECTS

  printf("\nSubject %d of %d: ", subject, SUBJECTS);
  run_block;
  allsubjects_RTs(subject,:) = output(:,3)';
  allsubjects_errors(subject,:) = output(:,2)';

end

printf ("\n");

mean_RT = mean(allsubjects_RTs);
sd_RT = std(allsubjects_RTs);

error_rate = mean(allsubjects_errors);






   # plot graph

  figure (1);
  plot ([1:1:BLOCKLENGTH], mean_RT);
  errorbar([1:1:BLOCKLENGTH], mean_RT, sd_RT);
  # hold on;
  set (gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11 12])
  set (gca, 'XTickLabel', stimuli_mixed(:,4)');
  title ("Mean Reaction Times");
  

  figure (2);
  plot ([1:1:BLOCKLENGTH], 1-error_rate);
  title ("Error Rate");
				# hold on;
  set (gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11 12])
  set (gca, 'XTickLabel', stimuli_mixed(:,4)');  
  hold on;

  printf ("\n switch cost: word->colour: %f cycles", \
	  (mean_RT(5) - sum(mean_RT(6:8)) / 3))
  printf ("\n switch cost: colour->word: %f cycles", \
	  (mean_RT(9) - sum(mean_RT(10:12)) / 3))



 

