#include <stdlib.h>
#include <stdio.h>
#include "pdp_objects.h"
#include "activation_functions.h"


#define ACT_MAX 1.0
#define ACT_MIN -1.0
#define STEP_SIZE 0.0015


/* Access functions: */
/* 1. reaction time (number of cycles to reach stopping condition) */
/* 2. response (ie. which node wins) */
/* 3. dump all activation values (ie. for drawing a graph of act vs. time) */




pdp_layer * pdp_layer_create(int size) {


    pdp_layer * new_layer;
    int i;

    new_layer = (pdp_layer *)malloc (sizeof(pdp_layer));
    new_layer->previous = NULL;
    new_layer->next = NULL;
    new_layer->size = size;
    new_layer->units = (double *)malloc (size * (sizeof(double)));
    
    /* layer should contain an array of accumulators, to sum net input  */
    new_layer->net_inputs = (double *)malloc (size * (sizeof(double)));

    for (i = 0; i < size; i++) {
      new_layer->net_inputs[i] = 0;
    }

    return new_layer;
}


void pdp_layer_free_fromtail(pdp_layer * some_layer) {
    /* recursively frees all iterations by following *previous* links */
    if (some_layer == NULL) {
        printf ("end of list reached, all done!\n");
        return;
    }
    else {
        pdp_layer * tmp;
        tmp = some_layer->previous;
        printf ("freeing memory at %p\n", some_layer);
        free (some_layer->units);
	free (some_layer->net_inputs);
        free (some_layer);
        pdp_layer_free_fromtail(tmp);
    }
}

pdp_weights_matrix * pdp_weights_create(int size_output, int size_input) {

  /*  TODO could probably combine this function with an initializer,
      can't think of a context you would want a weights matrix but not
      initialise it */

  pdp_weights_matrix * new_weights;
  new_weights = (pdp_weights_matrix*)malloc (sizeof(pdp_weights_matrix));
  new_weights->size_input = size_input;
  new_weights->size_output = size_output;
  new_weights->weights = malloc (size_output * sizeof(double*));
  
  int i;
  for (i = 0; i < size_output; i++) {
    new_weights->weights[i] = malloc(size_input * sizeof(double));
  }


  return new_weights;
}


void pdp_weights_set (pdp_weights_matrix * some_weights, 
		      int size_output, int size_input, double init_array[size_output][size_input]) {
  int out, in;

  for (out = 0; out < some_weights->size_output; out++) {
    for (in = 0; in < some_weights->size_input; in++) {
      some_weights->weights[out][in] = init_array[out][in];
    }
  }

  return;

}


/* <-------------- ALTERNATE VERSION ---------------> */
/*  
void pdp_weights_set_v1 (pdp_weights_matrix * some_weights, 
		      int size_output, int size_input, double * init_array) {
*/

/* initialises a weights matrix based on a specified array (ie. a
     calling function can set weights by using this function to point
     a weights matrix at a 2-dimensional array) */

  /* call like this:
       pdp_weights_set (some_weights, 3, 5, (double*)local_weights_matrix);
   */
/*
  int out, in;

  for (out = 0; out < some_weights->size_output; out++) {
    for (in = 0; in < some_weights->size_input; in++) {
      some_weights->weights[out][in] = init_array[size_input * out + in];
    }
  }

  return;
}
*/



void pdp_weights_print (struct pdp_weights_matrix * some_weights) {
/* mainly intended for debugging; print out weights matrix contained in the struct */
  int out, in;
  printf ("\n");
  for (out = 0; out < some_weights->size_output; out++) {
    printf ("|\t");
    for (in = 0; in < some_weights->size_input; in++) {
      printf ("%4.2f\t", some_weights->weights[out][in]);
    }
    printf ("|\n");
  }
  printf ("\n");
  return;
}

void pdp_weights_free (struct pdp_weights_matrix * some_weights) {
  int i;
  for (i = 0; i < some_weights->size_output; i ++) {
    free (some_weights->weights[i]);
  }
  free (some_weights->weights);
  free (some_weights);
  return;
}


/* TODO - some useful functions */

/* function for setting unit activation by using a local matrix */


/* pdp_calculate_input */
/* calculates the input to layer i from layer j by multiplying a
   weights matrix (W_ij) with a vector of activations reflecting an
   input layer. Must implment safety checks that the size of the
   matrix & the layer correspond. The result (input) is written to a
   set of accumulators in a specified output matrix. */

/* calculates input vector to output from a specified input, multiplied by a weights matrix */

int pdp_calc_input_fromlayer (int size_output, struct pdp_layer * output, 
			      int size_input, struct pdp_layer * input, 
			       struct pdp_weights_matrix * weights) {

  /* check sizes */
  int size_inputs, size_outputs, i, j;

  size_inputs = weights->size_input;
  size_outputs = weights->size_output;

  if (input->size != size_inputs) {
    /* raise an exception here!! */
    printf ("\nERROR! input size (%d) and weights matrix (%d) do not agree, terminating\n",
	    input->size, size_inputs);

    return 1;
  }

  else if  (output->size != size_outputs) {
    /* raise an exception here!! */
    printf ("\nERROR! output size (%d) and weights matrix (%d) do not agree, terminating\n",
	    output->size, size_outputs);

    return 1;
  }

  else {
    /* do the matrix multiplication */


    for (i = 0; i < size_output; i++) { /* calculate input to the ith output neuron */

      for (j = 0; j < size_input; j++) { /* calculate weighted input from jth input neuron */
	output->net_inputs[i] += input->units[j] * weights->weights[i][j];
      }
    }

  return 0;
  }

}
      
    


int main () {
 

  // pdp_layer * a_layer_head;
  pdp_layer * an_input;
  pdp_layer * an_output;



    /* a_layer = (pdp_layer *)malloc (sizeof(pdp_layer)); */
    an_input = pdp_layer_create(5);
    an_output = pdp_layer_create(3);
    // a_layer_head = a_layer_tail;
    an_input->units[0] = 0.5;
    an_input->units[1] = 0.1;
    an_input->units[2] = 0.1;
    an_input->units[3] = 0.1;
    an_input->units[4] = 0.5;

    an_output->units[0] = .1;
    an_output->units[1] = .1;
    an_output->units[2] = .1;



    /* init some weights */
    pdp_weights_matrix * some_weights;
    some_weights = pdp_weights_create (3,5);


    double local_weights_matrix[3][5] = {
      {0.0,  1.0, -4.0,  3.1,  2.5},
      {5.3, -1.3,  0.4, -5.2,  1.4},
      {3.0, -7.3, -3.5,  1.2,  7.1},
    };


    pdp_weights_set (some_weights, 3, 5, local_weights_matrix);


    /* cycle the model 10 times */

    int i;
    for (i = 0; i < 10; i++) {

      /* create layer for new cycle */
      pdp_layer * tmp = an_output;
      an_output = pdp_layer_create (3);
      an_output->previous = tmp;
      tmp->next = an_output;

	/* calculate inputs */
      pdp_calc_input_fromlayer (3, an_output, 5, an_input, some_weights);

      printf ("output unit activations: ");

      int outputunit = 0;
      for (outputunit = 0; outputunit < 3; outputunit ++) {
	an_output->units[outputunit] = act_gs(an_output->net_inputs[outputunit],
					      an_output->previous->units[outputunit],
                                            STEP_SIZE, ACT_MAX, ACT_MIN);

	printf ("\t[%d]: %4.2f\t", outputunit, an_output->units[outputunit]);
      }
    
      printf ("\n");
    }



    //    pdp_weights_print (some_weights);

    pdp_layer_free_fromtail (an_input);
    pdp_layer_free_fromtail (an_output);
    pdp_weights_free (some_weights);

    return 0;



}
