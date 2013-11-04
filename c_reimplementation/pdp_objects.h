


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




pdp_layer * pdp_layer_create(int size); 
void pdp_layer_free_fromtail(pdp_layer * some_layer);

pdp_weights_matrix * pdp_weights_create(int size_output, int size_input);
void pdp_weights_set (pdp_weights_matrix * some_weights, 
		      int size_output, int size_input, double * init_array);

void pdp_weights_print(struct pdp_weights_matrix * a_weights_matrix);
void pdp_weights_free (struct pdp_weights_matrix * some_weights);
