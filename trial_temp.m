## temporary skeleton - script for setting up and running model (single
## trial)

close all;
clear all;


initglobals


# temp - apply R input to word output units and update for 100 cycles

units_wordin = [1 0 0] 
units_colourin = [0 1 0]

for t = 1:1000

# calculate input to wordout nodes

  inputto_units_wordout = OUTPUTUNIT_BIAS + \
        sum((units_wordin .*  weights_wordin_wordout), 2)' \
      + sum((units_wordout(t,:) .* weights_wordout_wordout), 2)' \
      + sum((units_colourout(t,:) .* weights_colourout_wordout), 2)'

  inputto_units_colourout = OUTPUTUNIT_BIAS + \
        sum((units_colourin .*  weights_colourin_colourout), 2)' \
      + sum((units_colourout(t,:) .* weights_colourout_colourout), 2)' \
      + sum((units_wordout(t,:) .* weights_wordout_colourout), 2)'



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


end

figure (1);
plot ([0:1:t], [units_wordout units_colourout]);
legend ('word out R', 'word out G', 'word out B', 'colour out R', \
	'colour out G', 'colour out B')
hold on;
