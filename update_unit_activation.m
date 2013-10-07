function units_wordout = update_unit_activation \
      (units_wordout, net_input, step_size, act_max, act_min)

# implements gilbert & shallice (2002) activation equation:
# activation_gilbertshallice.m


# update word units activation only

t = rows(units_wordout) # get current timestep

for i = 1:columns(units_wordout)

  units_wordout(t+1,i) = activation_gilbertshallice (net_input(i), \
						     units_wordout(t,i), \
						     step_size, \
						     act_max, act_min);
end

endfunction


