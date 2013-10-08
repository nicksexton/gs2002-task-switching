function stimuli = stimblock_create (blocklength, blocktype, runs)

				# returns a switching stroop stimuli
				# block of [blocklength] trials,
				# [blocktype] may be (1) fixedword (2)
				# fixedcolour or (3) mixed. runs gives
				# the length of consecutive trials of
				# same task. Note blocklength should be
				# a multiple of runs otherwise things
				# might be messy. ALSO - function will
				# generate 1/3 cong, 1/3 incong and 1/3
				# neutral trials

stim_type = randi ([0 2], blocklength, 1);

stimuli = [];

for trial = 1:blocklength

				# work out task based on current trial
				# blocktype  
  if (blocktype == 1)
    task = 1;
  elseif (blocktype == 2)
    task = 2;
  elseif (blocktype == 3)
    task = 1 + mod (idivide((trial-1), runs, 'floor'), 2);
  else printf ("blocktype not recognised, options are 1 (fixedword), \
	2 (fixedcolour) or 3 (mixed)\n");
  end


  stim_word = randi ([1 3], 1, 1); # R = 1, G = 2, B = 3, N(one) = 0

  if (stim_type(trial) == 0)    
    stim_colour = 0;
  elseif (stim_type(trial) == 1)
    stim_colour = stim_word;

  elseif (stim_type(trial) == 2)
    incongruent_colour = randi ([0 1], 1, 1); # remaining two colours

    # contingency if word = red
    if (stim_word == 1)
      if (incongruent_colour == 0)
	stim_colour = 2; # green
      else
	stim_colour = 3; # blue
      end

      # contingency if word = green
    elseif (stim_word == 2)
      if (incongruent_colour == 0)
	stim_colour = 3; # blue
      else
	stim_colour = 1; # red
      end

      # contingency if word = blue
    elseif (stim_word == 3)
      if (incongruent_colour == 0)
	stim_colour = 1; # red
      else
	stim_colour = 2; # green
      end

    else printf ("\nuh oh\n");

    end

    else printf ("\nuh oh outer loop\n");
  end


  # to handle neutral trials for the colournaming task;
  # simply switch stim_colour and stim_word!
  if (task == 2)
    temp = stim_colour;
    stim_colour = stim_word;
    stim_word = temp;
  end

stimuli = [stimuli; \
	   stim_word stim_colour stim_type(trial) task];

end

endfunction