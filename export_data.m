% Mini script to export data from fixed_blocks to a text file

% Coding: 
% 1st column, task (0 = word reading, 1 = colour naming)
% 2nd column, stimuli (0 = neutral, 1 = congruent, 2 = incongruent)

data_word_n = cat(2, repmat (0, rows(word_neutral), 1), repmat (0, rows(word_neutral), 1), word_neutral)
data_word_c = cat(2, repmat (0, rows(word_congruent), 1), repmat (1, rows(word_congruent), 1), word_congruent)
data_word_i = cat(2, repmat (0, rows(word_incongruent), 1), repmat (2, rows(word_incongruent), 1), word_incongruent)
data_colour_n = cat(2, repmat (1, rows(colour_neutral), 1), repmat (0, rows(colour_neutral), 1), colour_neutral)
data_colour_c = cat(2, repmat (1, rows(colour_congruent), 1), repmat (1, rows(colour_congruent), 1), colour_congruent)
data_colour_i = cat(2, repmat (1, rows(colour_incongruent), 1), repmat (2, rows(colour_incongruent), 1), colour_incongruent)

data = cat (1, data_word_n, data_word_c, data_word_i, data_colour_n, data_colour_c, data_colour_i)

dlmwrite ("gs_stroop_fixed_results.txt", data)