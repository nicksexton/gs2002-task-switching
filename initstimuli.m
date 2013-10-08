# script to initialise stimuli


BLOCKLENGTH = 12;

# STIMULI TYPE: neutral = 0, congruent = 1, incongruent = 2
# TASK: word reading = 1, colour naming = 2
# COLOURS: R = 1, G = 2, B = 3, N(one) = 0

# FORMAT: [WORD COLOUR TYPE TASK]

# init fixed block stimuli


# fixed block: word reading
stim_type = randi ([0 2], BLOCKLENGTH, 1);

stimuli_fixed_word = [];

for trial = 1:BLOCKLENGTH
  
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

stimuli_fixed_word = [stimuli_fixed_word; \
		      stim_word stim_colour stim_type(trial) 1];

  clear stim_word;
  clear stim_colour;
  clear incongruent_colour;
  

end