% analysis of model performance on fixed blocks
% corresponds to Shallice & Gilbert 2002 p.311
% main empirical effect: Stroop interference and facilitation
% on congruent, incongruent and neutral trials

close all;
clear all;
initglobals
% initstimuli 

BLOCKLENGTH = 12;
RUNS = 4;
SUBJECTS = 50; % use 100 for teaching
stimuli_mixed = [];

%identical stimuli (?)
for trial = 1:BLOCKLENGTH
  stimuli_mixed = [stimuli_mixed; 1 2 2 1+mod(floor((trial-1)/RUNS), 2)]; 
end
STIM_THIS_BLOCK = stimuli_mixed;




PREP_INTERVAL = 1 % max 150 in GS2002
for subject = 1:SUBJECTS

    %  fprintf('\nSubject %d of %d: ', subject, SUBJECTS);
  run_block_withpreparation;
  allsubjects_RTs(subject,:) = output(:,3)';
  allsubjects_errors(subject,:) = output(:,2)';

end

  % FOR THESIS VERSION - EXPORT DATA
  save -ascii data/fig4_rts_prep_01.txt allsubjects_RTs
  save -ascii data/fig4_errors_prep_01.txt allsubjects_errors

  % Plot graphs here for teaching



  PREP_INTERVAL = 26 % max 150 in GS2002
for subject = 1:SUBJECTS

    %  fprintf('\nSubject %d of %d: ', subject, SUBJECTS);
  run_block_withpreparation;
  allsubjects_RTs(subject,:) = output(:,3)';
  allsubjects_errors(subject,:) = output(:,2)';

end

  % FOR THESIS VERSION - EXPORT DATA
  save -ascii data/fig4_rts_prep_26.txt allsubjects_RTs
  save -ascii data/fig4_errors_prep_26.txt allsubjects_errors




    PREP_INTERVAL = 61 % max 150 in GS2002
for subject = 1:SUBJECTS

    %  fprintf('\nSubject %d of %d: ', subject, SUBJECTS);
  run_block_withpreparation;
  allsubjects_RTs(subject,:) = output(:,3)';
  allsubjects_errors(subject,:) = output(:,2)';

end

  % FOR THESIS VERSION - EXPORT DATA
  save -ascii data/fig4_rts_prep_61.txt allsubjects_RTs
  save -ascii data/fig4_errors_prep_61.txt allsubjects_errors


  

  PREP_INTERVAL = 150 % max 150 in GS2002
for subject = 1:SUBJECTS

    %  fprintf('\nSubject %d of %d: ', subject, SUBJECTS);
  run_block_withpreparation;
  allsubjects_RTs(subject,:) = output(:,3)';
  allsubjects_errors(subject,:) = output(:,2)';

end

  % FOR THESIS VERSION - EXPORT DATA
  save -ascii data/fig4_rts_prep_150.txt allsubjects_RTs
  save -ascii data/fig4_errors_prep_150.txt allsubjects_errors
  


   % plot graph

   %  figure (1);
   %plot ([1:1:BLOCKLENGTH], mean_RT);
   %errorbar([1:1:BLOCKLENGTH], mean_RT, sd_RT);

   %set (gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11 12])
   %set (gca, 'XTickLabel', stimuli_mixed(:,4)');
   %title ('Mean Reaction Times');
  

   %figure (2);
   %plot ([1:1:BLOCKLENGTH], 1-error_rate);
   %title ('Error Rate');
			
   %  set (gca, 'XTick', [1 2 3 4 5 6 7 8 9 10 11 12])
   %set (gca, 'XTickLabel', stimuli_mixed(:,4)');  
   %hold on;

   %fprintf ('\n switch cost: word->colour: %f cycles', ...
   %	  (mean_RT(5) - sum(mean_RT(6:8)) / 3));
   %fprintf ('\n switch cost: colour->word: %f cycles', ...
   %	  (mean_RT(9) - sum(mean_RT(10:12)) / 3));
   %fprintf ('\n');
   % 

 

