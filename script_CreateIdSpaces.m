% The script calls the id_space_linear.m function
% and creates ii address spaces that saves in a folder.

clear;
clc;

for ii=1:500
    % number_of_nodes = 10^ii*1000;
    number_of_nodes = 1000;
    [m, n_nodes, nodes, routing_tables, predecessors, dist_nodes, attackers] = Id_Space_Linear(23, number_of_nodes);
    save(['experiments/networks/' num2str(number_of_nodes) '_nodes/AddressSpace' num2str(ii) '.mat'],'')
end