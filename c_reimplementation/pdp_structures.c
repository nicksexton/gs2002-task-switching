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
    new_layer = (pdp_layer *)malloc (sizeof(pdp_layer));
    new_layer->previous = NULL;
    new_layer->next = NULL;
    new_layer->size = size;
    new_layer->units = (double *)malloc (size * (sizeof(double)));

    /* layer should contain an array of accumulators, reflecting the input to the layer on this  */

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
		      int size_output, int size_input, double * init_array) {

  /* initialises a weights matrix based on a specified array (ie. a
     calling function can set weights by using this function to point
     a weights matrix at a 2-dimensional array) */

  int out, in;

  for (out = 0; out < some_weights->size_output; out++) {
    for (in = 0; in < some_weights->size_input; in++) {
      some_weights->weights[out][in] = init_array[size_input * out + in];
    }

  }

  return;

}


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




/* pdp_weights_assign (pdp_weights_matrix, int size_i, int size_j, double ** weights_array) */
/* ie. function which assigns weights to a matrix by specifying an array */



/* pdp_calculate_input */
/* calculates the input to layer i from layer j by multiplying a
   weights matrix (W_ij) with a vector of activations reflecting an
   input layer. Must implment safety checks that the size of the
   matrix & the layer correspond. The result (input) is written to a
   set of accumulators in a specified output matrix. */




int main () {
 

  // pdp_layer * a_layer_head;
    pdp_layer * a_layer_tail;



    /* a_layer = (pdp_layer *)malloc (sizeof(pdp_layer)); */
    a_layer_tail = pdp_layer_create(3);
    // a_layer_head = a_layer_tail;
    a_layer_tail->units[0] = 0.5;
    a_layer_tail->units[1] = -0.5;
    a_layer_tail->units[2] = 1;



    /* init some weights */
    pdp_weights_matrix * some_weights;
    some_weights = pdp_weights_create (3,5);


    double local_weights_matrix[3][5] = {
      {0.0,  0.1, -0.1,  0.1,  0.1},
      {0.3, -0.1,  0.1,  0.3,  0.4},
      {0.0, -0.3, -0.5,  0.2,  0.1},
    };

    pdp_weights_set (some_weights, 3, 5, (double*)local_weights_matrix);


    /* printf ("\n some weights: %2.1f, %2.1f, %2.1f", some_weights->weights[0][0], 
						     some_weights->weights[0][1],
   	 					     some_weights->weights[0][2]);
    */


    pdp_weights_print (some_weights);

    pdp_layer_free_fromtail (a_layer_tail);
    pdp_weights_free (some_weights);

    return 0;



}
