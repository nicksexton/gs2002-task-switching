


/* A layer of units */
typedef struct pdp_layer {

    struct pdp_layer * previous; // past iterations
    struct pdp_layer * next;     // future iterations
    int size;
    double * units; // pointer to array (ie. row matrix) of unit activation values, UNINITIALISED
    double * net_inputs; // accumulators for summing net input, initialised to zero

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
			 int size_output, int size_input, double init_array[size_output][size_input]);

/* <-------------- Alternate version --------------------->
void pdp_weights_set_v1 (pdp_weights_matrix * some_weights, 
		      int size_output, int size_input, double * init_array);
*/

int pdp_calc_input_fromlayer (int size_output, struct pdp_layer * output, 
			      int size_input, struct pdp_layer * input, 
			      struct pdp_weights_matrix * weights);



void pdp_weights_print(struct pdp_weights_matrix * a_weights_matrix);
void pdp_weights_free (struct pdp_weights_matrix * some_weights);
