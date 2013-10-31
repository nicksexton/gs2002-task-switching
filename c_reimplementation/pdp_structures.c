#include <stdlib.h>
#include <stdio.h>

/* Access functions: */
/* 1. reaction time (number of cycles to reach stopping condition) */
/* 2. response (ie. which node wins) */
/* 3. dump all activation values (ie. for drawing a graph of act vs. time) */


/* A layer of units */
typedef struct layer { 

  struct layer * previous; // past iterations
  struct layer * next;     // future iterations
  int size;
  double * units; // pointer to array which contains our data
} layer;


layer * layer_create(int size) {
  layer * new_layer;
  new_layer = (layer *)malloc (sizeof(layer));
  new_layer->previous = NULL;
  new_layer->next = NULL;
  new_layer->size = size;
  new_layer->units = (double *)malloc (size * (sizeof(double)));

  return new_layer;
}


void layer_free_backward(layer * some_layer) {
/* recursively frees all iterations by following *previous* links */
  if (some_layer == NULL) {
    printf ("end of list reached, all done!\n");
    return;
  }
  else {
    layer * tmp;
    tmp = some_layer->previous;
    printf ("freeing memory at %p\n", some_layer);
    free (some_layer->units);
    free (some_layer);
    layer_free_backward(tmp); 
  }   
}


int main () {
  layer * a_layer_head;
  layer * a_layer_tail;

  /* a_layer = (layer *)malloc (sizeof(layer)); */ 
  a_layer_tail = layer_create(3);
  a_layer_head = a_layer_tail;
  a_layer_tail->units[0] = 1;
  a_layer_tail->units[1] = 2;
  a_layer_tail->units[2] = 3;

  printf ("\n");
  printf ("red = %2.1f, green = %2.1f, blue = %2.1f\n", 
	  a_layer_tail->units[0], a_layer_tail->units[1], a_layer_tail->units[2]);

  /* now iterate the layer multiplying by 1.2 */

  int i;
  for (i = 0; i < 10; i++) {
    layer * tmp = a_layer_tail;
    a_layer_tail = layer_create(3);
    a_layer_tail->previous = tmp;
    tmp->next = a_layer_tail;

    int u;
    for (u = 0; u < a_layer_tail->size; u++) {
      a_layer_tail->units[u] = a_layer_tail->previous->units[u] * 1.2;
    }
  }

  
  printf ("dump data backwards:\n");

  layer * layer_iterator = a_layer_tail;
  while (layer_iterator != NULL) {
    printf ("red = %2.1f, green = %2.1f, blue = %2.1f\n", 
	    layer_iterator->units[0], layer_iterator->units[1], layer_iterator->units[2]);  
    layer_iterator = layer_iterator->previous;
  }

  printf ("dump data forwards:\n");

  layer_iterator = a_layer_head;
  while (layer_iterator != NULL) {
    printf ("red = %2.1f, green = %2.1f, blue = %2.1f\n", 
	    layer_iterator->units[0], layer_iterator->units[1], layer_iterator->units[2]);  
    layer_iterator = layer_iterator->next;
  }


  layer_free_backward (a_layer_tail);
  return 0;
}
