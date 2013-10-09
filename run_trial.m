## script for running a single trial
## trial)

# IMPORTANT - these variables should be set by any calling script (ie.
# managing a block of trials)

# units_wordin = [1 0 0] # [R G B]
# units_colourin = [0 1 0] # [R G B]
# topdown_input = [1 0] # top down control is either 1 (on) or 0 (off)

t = 0;
difference = 0; # between biggest and next biggest output
		# activation (terminating condition)

while (difference < RESPONSE_THRESHOLD) 

  t = t + 1;  

# calculate input to wordout nodes

  inputto_units_wordout = OUTPUTUNIT_BIAS + \
        units_wordin * weights_wordin_wordout + \
        units_wordout(t,:) * weights_wordout_wordout + \
        units_colourout(t,:) * weights_colourout_wordout + \
        units_taskdemand(t,:) * weights_taskdemand_wordout;

  inputto_units_colourout = OUTPUTUNIT_BIAS + \
        units_colourin * weights_colourin_colourout + \
        units_colourout(t,:) * weights_colourout_colourout + \
        units_wordout(t,:) * weights_wordout_colourout + \
        units_taskdemand(t,:) * weights_taskdemand_colourout;

  inputto_units_taskdemand = TASKDEMAND_BIAS + \
        (topdown_input .* TOPDOWN_CONTROL_STRENGTH) + \
        units_wordout(t,:) * weights_wordout_taskdemand + \
        units_colourout(t,:) * weights_colourout_taskdemand; #
				#remember to add FF connections from
				#input units


# update wordout units

  units_wordout = update_unit_activation (units_wordout,
					  inputto_units_wordout, \
					  STEP_SIZE,
					  ACTIVATION_MAX, \
					  ACTIVATION_MIN);
  
  units_colourout = update_unit_activation (units_colourout,
					  inputto_units_colourout, \
					  STEP_SIZE,
					  ACTIVATION_MAX, \
					  ACTIVATION_MIN);
  
  units_taskdemand = update_unit_activation (units_taskdemand, \
					     inputto_units_taskdemand, \
					     STEP_SIZE,
					     ACTIVATION_MAX, \
					     ACTIVATION_MIN);

  # calculate terminating condition
  [sorted_activations ranking] = \
      sort([units_wordout(t,:) units_colourout(t,:)], 'descend');

  if (ranking(2)-ranking(1) == abs(3))
    difference = sorted_activations(1) - sorted_activations(3);
  else
    difference = sorted_activations(1) - sorted_activations(2);
  end

end


#figure (1);
#plot ([units_wordout units_colourout]);
#legend ('word out R', 'word out G', 'word out B', 'colour out R', \
#	'colour out G', 'colour out B');
#hold on;

#figure (2);
#plot (units_taskdemand);
#legend ('word', 'colour');
#hold on;
