function units_wordout_new = update_unit_activation ...
      (units_wordout, net_input, step_size, act_max, act_min, noise)

% implements gilbert & shallice (2002) activation equation:
% activation_gilbertshallice.m

% update word units activation only

%t = rows(units_wordout);    % get current timestep
[t,ncols] = size(units_wordout);    % get current timestep


for i = 1:ncols

  units_wordout(t+1,i) = activation_gilbertshallice (net_input(i), ...
						     units_wordout(t,i), ...
						     step_size, ...
						     act_max, act_min) ...
                    + (noise .* randn(1));

  % clip activation values to between -1 and +1
  if (units_wordout(t+1,i) > 1) 
    units_wordout(t+1,i) = 1;
  elseif (units_wordout(t+1,i) < -1)
    units_wordout(t+1,i) = -1;
  end


end

units_wordout_new = units_wordout;

%endfunction
end

