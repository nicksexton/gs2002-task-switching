% script to initialise stimuli


BLOCKLENGTH = 12;
RUNS = 4;

% STIMULI TYPE: neutral = 0, congruent = 1, incongruent = 2
% TASK: word reading = 1, colour naming = 2
% COLOURS: R = 1, G = 2, B = 3, N(one) = 0

% FORMAT: [WORD COLOUR TYPE TASK]

% init fixed block stimuli


% fixed block: word reading
stimuli_fixed_word = stimblock_create (BLOCKLENGTH, 1, RUNS);
stimuli_fixed_colour = stimblock_create (BLOCKLENGTH, 2, RUNS);
stimuli_mixed = stimblock_create (BLOCKLENGTH, 3, RUNS);
