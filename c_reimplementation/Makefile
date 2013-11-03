CC=gcc
CFLAGS=-Wall -g

all:  pdp_structures

pdp_structures: pdp_structures.o activation_functions.o 
pdp_structures.o: pdp_structures.c  
activation_functions.o: activation_functions.c

clean: rm -f pdp_structures pdp_structures.o activation_functions.o