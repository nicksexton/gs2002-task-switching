
%% Uncomment one of the following blocks to vary 
%% Varying positive/negative task demand activation to output units
% hold pos task demand activation constant
%     % taskdemand_pos = 2.5 + NOISE_TASKDEMAND * randn(1);
%     taskdemand_neg = - 2.5;
%     IV_parameter = 2.5 + NOISE_TASKDEMAND * randn(1);
%     taskdemand_pos = IV_parameter;
% 
%     % Print the subject number to the editor to monitor progress of simulation
%     fprintf ('SUBJECT:%d\t TD weights %3.2f %3.2f\t', subject, taskdemand_pos, taskdemand_neg)
% 
%     weights_taskdemand_wordout = ...
%         [taskdemand_pos taskdemand_pos taskdemand_pos; ...
%          taskdemand_neg taskdemand_neg taskdemand_neg];
%     
%     weights_taskdemand_colourout = ...
%         [taskdemand_neg taskdemand_neg taskdemand_neg; ...
%          taskdemand_pos taskdemand_pos taskdemand_pos]; 
     
 %% Varying lateral inhibition in task demand units
 

 
 