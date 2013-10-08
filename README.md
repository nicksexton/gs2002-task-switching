gs2002-task-switching
=====================
Implementation of the Gilbert & Shallice 2002 task switching model in Octave




init_globals.m 	  <- initialises global variables & parameters 

run_trial.m 	  <- script which runs a single trial instance (terminates
		  when difference between biggest activation and next biggest
		  is greater than RESPONSE_THRESHOLD

		  nb. yet to implement:
		  [ ] preparation interval
		  [ ] bottom-up connections to task demand units
		  [ ] associative (hebbian) learning
		  [ ] noise


A trial consists of:
1) init model
2) Preparation Interval
3) Stimulus Onset & settling
