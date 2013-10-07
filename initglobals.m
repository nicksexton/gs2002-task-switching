# Global parameters

ACTIVATION_MAX = 1.0
ACTIVATION_MIN = -1.0
RESPONSE_THRESHOLD = 0.15
STEP_SIZE = 0.0015
SQUASHING_PARAM = 0.8     # task demand unit activation scaling between
			  # trials
NOISE = 0.006             # SD of gaussian noise


## Initialises model and global variables for task switching model

units_wordout = [0 0 0];
units_colourout = [0 0 0];

units_wordin = [0 0 0];
units_colourin = [0 0 0];

units_taskdemand = [0 0]; # [word colour]


# module feed-forward weights
weights_wordin_wordout     = [3.5 0.0 0.0; 0.0 3.5 0.0; 0.0 0.0 3.5];
weights_colourin_colourout = [1.9 0.0 0.0; 0.0 1.9 0.0; 0.0 0.0 1.9];

# word/colour cross connections
weights_wordout_colourout = [+2 -2 -2; -2 +2 -2; -2 -2 +2];
weights_colourout_wordout = [+2 -2 -2; -2 +2 -2; -2 -2 +2];

# within-module lateral connections
weights_wordout_wordout     = [ 0 -2 -2; -2  0 -2; -2 -2  0];
weights_colourout_colourout = [ 0 -2 -2; -2  0 -2; -2 -2  0];

