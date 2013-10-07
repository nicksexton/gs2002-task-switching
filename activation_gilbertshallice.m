function new_activation = activation_gilbertshallice (net_input, \
						  old_activation, \
						  step_size,
						  act_max, act_min)

## Update unit activation using Gilbert/Shallice 2002 equations
## (based on McClelland & Rumelhart 1981 IAC equations)
## See Gilbert & Shallice 2002 p.309 for detail
## change_in_activation = 

% old_activation = activation value on previous cycle

if (nargin != 5)
  error ("usage: activation_gilbertshallice (net_input, old_activation, \
					step_size, act_max, act_min)")
endif

% eta (effect of net input on node) 
if (net_input > 0)  
  eta = net_input * (act_max - old_activation);
elseif (net_input < 0)
  eta = net_input * (old_activation - act_min);
else
  eta = 0;
end

new_activation = old_activation + (step_size * eta);

endfunction