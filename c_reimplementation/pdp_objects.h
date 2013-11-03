


/* A layer of units */
typedef struct pdp_layer {

    struct pdp_layer * previous; // past iterations
    struct pdp_layer * next;     // future iterations
    int size;
    double * units; // pointer to array (ie. row matrix) which contains our data
} pdp_layer;




/* A weights structure */
typedef struct pdp_weights_matrix {

  int size_input;
  int size_output;
  /* ie define a size_inputs rows x size_outputs cols matrix */

  double ** weights;

} pdp_weights_matrix;




pdp_layer * layer_create(int size); 
void layer_free_backward(pdp_layer * some_layer);

pdp_weights_matrix * pdp_weights_create(int size_input, int size_output);
