% skeleton for running block of trials WITH PREP INTERVAL



% STIM_THIS_BLOCK = stimuli_fixed_colour;
output = [];

units_taskdemand = [0 0]; % need to prevent spill over of activation
			  % between trials

units_taskdemand_prep = [0 0]; % use as a buffer to deal with TD
                               % activation before timer starts 

for trial = 1:BLOCKLENGTH
  
  units_wordin    = [0 0 0];
  units_colourin  = [0 0 0];
  units_wordout   = [0 0 0];
  units_colourout = [0 0 0];
  topdown_input   = [0 0];
  
  
  
  units_taskdemand_prep = units_taskdemand(end,:) ...
      * (1-SQUASHING_PARAM);

  % set top down control inputs
  topdown_input(STIM_THIS_BLOCK(trial, 4)) = 1;

  % CYCLE TD UNITS ONLY FOR PREPARATION INTERVAL
  t_prep = 1; % preparation counter
  while (t_prep <= PREP_INTERVAL)
      inputto_units_taskdemand = TASKDEMAND_BIAS + ...
          (topdown_input .* TOPDOWN_CONTROL_STRENGTH) + ...
          units_taskdemand_prep(t_prep,:) * weights_taskdemand_taskdemand;

      units_taskdemand_prep = update_unit_activation (units_taskdemand_prep, ...
                                                 inputto_units_taskdemand, ...
                                                 STEP_SIZE, ...
                                                 ACTIVATION_MAX, ...
                                                 ACTIVATION_MIN, ...
                                                 NOISE); 

      t_prep = t_prep + 1;

  end
  

  units_taskdemand = units_taskdemand_prep(end,:);
  
  % STIM_THIS_BLOCK format: [WORD COLOUR TYPE TASK]
  if (STIM_THIS_BLOCK(trial,1) > 0)
    units_wordin(STIM_THIS_BLOCK(trial, 1)) = 1;
  end

  if (STIM_THIS_BLOCK(trial,2) > 0)
    units_colourin(STIM_THIS_BLOCK(trial, 2)) = 1;
  end


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

% print progress report to screen
%  if mod(trial,100) == 0
%        fprintf ('%d ', trial);
%  end

end