gs2002-task-switching

Branch - indiff_fixed 
===================== 
implementing variant of switching stroop model which simulates 
between-subjects differences by adding noise to connection weights






=====================
Implementation of the Gilbert & Shallice 2002 task switching model in Octave

simulation_fixedblocks.m      <- replication of straightforward stroop 
			      interference/facilitation effect in fixed blocks
			      (eg., all colour naming or all word reading) 



initglobals.m 	  <- script to initialise global variables & parameters 
initstimuli.m 	  <- script to initialise stimuli using stimblock_create
run_trial.m 	  <- script which runs a single trial instance (terminates
		  when difference between biggest activation and next biggest
		  is greater than RESPONSE_THRESHOLD

		  nb. yet to implement:
		  [ ] preparation interval
		  [ ] bottom-up connections to task demand units
		  [ ] associative (hebbian) learning
		  [ ] noise


run_block.m	  <- runs a block of trials of length BLOCKLENGTH
		  produces matrix 'output'
		  output format [response, 1(correct)/0(incorrect), cycles]


stimblock_create.m  <- function stimblock_create(blocklength, type, runs) 
		    - creates a block of stimuli of the format 

FORMAT: [WORD COLOUR TYPE TASK]
STIMULI TYPE: neutral = 0, congruent = 1, incongruent = 2
TASK: word reading = 1, colour naming = 2
COLOURS: R = 1, G = 2, B = 3, N(one) = 0


A trial consists of:
1) init model
2) Preparation Interval
3) Stimulus Onset & settling
