% skeleton for running block of trials



% STIM_THIS_BLOCK = stimuli_fixed_colour;
output = [];

units_taskdemand = [0 0]; % need to prevent spill over of activation
			  % between trials


for trial = 1:BLOCKLENGTH
  
  units_wordin    = [0 0 0];
  units_colourin  = [0 0 0];
  units_wordout   = [0 0 0];
  units_colourout = [0 0 0];
  topdown_input   = [0 0];
  
  
  
  units_taskdemand = units_taskdemand(end,:) ...
      * (1-SQUASHING_PARAM);

  % STIM_THIS_BLOCK format: [WORD COLOUR TYPE TASK]
  if (STIM_THIS_BLOCK(trial,1) > 0)
    units_wordin(STIM_THIS_BLOCK(trial, 1)) = 1;
  end

  if (STIM_THIS_BLOCK(trial,2) > 0)
    units_colourin(STIM_THIS_BLOCK(trial, 2)) = 1;
  end

  topdown_input(STIM_THIS_BLOCK(trial, 4)) = 1;
  t = 0; % count for cycles
  run_trial;

  [temp most_active_node] = max ([units_wordout(t,:) units_colourout(t,:)]);

  response = most_active_node;
  if response > 3
    response = response - 3;
  end

  if (response == ...
      STIM_THIS_BLOCK(trial,STIM_THIS_BLOCK(trial,4)))
      
    output(trial,:) = [response 1 t]; % correct
  else
    output(trial,:) = [response 0 t]; % incorrect
  end

  fprintf ('%d ', trial);

end