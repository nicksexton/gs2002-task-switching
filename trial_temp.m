## temporary skeleton - script for setting up and running model (single
## trial)



initglobals


# temp - apply R input to word output units and update for 100 cycles

units_wordin = [1 0 0] # apply directly (ie with no weights) for now

for t = 1:100

  units_wordout = update_unit_activation (units_wordout,
					  units_wordin, \
					  STEP_SIZE,
					  ACTIVATION_MAX, \
					  ACTIVATION_MIN);

end

figure (1);
plot ([0:1:100], units_wordout);
hold on;
