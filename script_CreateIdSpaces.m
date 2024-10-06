% The script calls the id_space_linear.m function
% and creates ii address spaces that saves in a folder.

clear;
clc;

number_of_IdSpaces = 5;

for ii=1:number_of_IdSpaces

    number_of_nodes = 1000;
    length_of_IdSpace = 23; % the id space will have 2^length_of_IdSpace addresses

    [m, n_nodes, nodes, routing_tables, predecessors, dist_nodes, attackers] = Id_Space_Linear(length_of_IdSpace, number_of_nodes);

    dir_name = ['experiments/networks/' num2str(number_of_nodes) '_nodes/'];
    if ~(exist(dir_name,'dir'))
        mkdir (dir_name);
    end

    save(['experiments/networks/' num2str(number_of_nodes) '_nodes/AddressSpace' num2str(ii) '.mat'])
end
