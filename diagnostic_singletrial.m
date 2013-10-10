
# clear all;
close all;

# initglobals;



units_wordin = [1 0 0] # [R G B]
units_colourin = [0 1 0] # [R G B]
topdown_input = [1 0] # top down control is either 1 (on) or 0 (off)


run_trial


figure (1);
plot ([units_wordout units_colourout]);
legend ('word out R', 'word out G', 'word out B', 'colour out R', \
	'colour out G', 'colour out B');
hold on;

figure (2);
plot (units_taskdemand);
legend ('word', 'colour');
hold on;