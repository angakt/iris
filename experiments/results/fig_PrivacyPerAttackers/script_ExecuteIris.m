% The script runs ii the Iris algorithm and saves the execution data in a file.
% Between execution the alpha and delta parameters, and the fraction of attackers remain stable
% but the id_space, the requester node (N_r) and the target address (O_p) change.
% N_r and O_p are chosen uniformly at random from the registered nodes and the id_space, respectively.

clear;
clc;

% Chose the below two variables based on the
% id spaces created with the script_CreateIdSpaces.m file
number_of_nodes = 1000;
length_of_IdSpace = 23;

% For every experiment we use another id space,
% thus, make sure you have this number of different
% id spaces saved in your folder.
number_of_experiments = 500;

for jj=1:5

    dist_N2Op = zeros(number_of_experiments,500);
    dist_N2Ir = zeros(number_of_experiments,500);
    priv_data = zeros(number_of_experiments,500);
    ub_data = zeros(number_of_experiments,500);
    addresses_of_nodes = zeros(number_of_experiments,500);
    addresses_of_objects = zeros(number_of_experiments,500);
    random_points = zeros(number_of_experiments,500);
    targets = zeros(number_of_experiments,1);

    for ii=1:number_of_experiments
    
    %% Load the variables of the id_space   
    load(['experiments/networks/' num2str(number_of_nodes) '_nodes/AddressSpace' num2str(ii) '.mat'])
    msg_0 = [newline '%%% Done loading file ', num2str(ii), ' %%%'];
    disp(msg_0)
    disp(' ');
    
    % alpha \in [0,1)
    % For the experiments we have chosen the following
    % values: 0.25, 0.35, 0.5, 0.75
    alpha = 0.25;

    % delta \in [1,2^length_of_IdSpace]
	% For the experiments we have chosen the following
	% fractions: 1/4, 1/8, 1/16, 1/32, 1/64, 1/128
    delta = 2^length_of_IdSpace/4;
    
    % The mat files of the id spaces saves
    % the attackers in the attackers variable every row
    % of which has the attackers of a specific fraction:
    % 0, 1/2, 1/3, 1/6, 1/8

    switch jj
        case 1
            mal_nodes=attackers(1,:);
            name = '00';
        case 2
            mal_nodes=attackers(2,:);
            name = '12';
        case 3
            mal_nodes=attackers(3,:);
            name = '13';
        case 4
            mal_nodes=attackers(4,:);
            name = '16';
        case 5
            mal_nodes=attackers(5,:);
            name = '18';
        otherwise
            disp('more loops than defined attacker fractions')
    end

    % for ii=1:100
    
    % The requester is chosen randomly among the participating nodes
    N_r = nodes(randi(numel(nodes)));
    % Check that the requester is not one of the colluding nodes
    while ismember(N_r, mal_nodes)==1
      % msg = 'We chose another Nr';
      % disp(msg)
      N_r = nodes(randi(numel(nodes)));
    end
    
    % As the networks are different the requester could be
    % the first node in the network without loss of generality, but why not :)
    % N_r = nodes(1,1);
    
    % The distance the requester assumes between nodes
    ind = find(dist_nodes==N_r,1);
    d_nodes = dist_nodes(ind,4);
    
    % The target object---a random number in the interval [a,b]
    
    % %     a = N_r;
    % %     b = mod(N_r+((2^m)/2),2^m);
    
    a = 1;
    b = 2^m;
    O_p = round(a + (b-a).*rand(1,1));
    
    % % To test probabilities
    % O_p = Checking_Target(delta, nodes, m);
    
    % % Check that the responsible node for the target object is not one of the colluding nodes
    % index_resp_node = find(nodes>=O_p,1); % The index of the responsible node
    % if isempty(index_resp_node) == 0
    %     resp_node = nodes(index_resp_node); % The responsible node
    % elseif isempty(index_resp_node) == 1
    %     resp_node = nodes(1);
    % end
    %
    % while ismember(resp_node, mal_nodes)==1
    %     % msg = 'We chose another Op';
    %     % disp(msg)
    %     O_p = round(a + (b-a).*rand(1,1));
    %     index_resp_node = find(nodes>=O_p,1); % The index of the responsible node
    %     if isempty(index_resp_node) == 0
    %        resp_node = nodes(index_resp_node); % The responsible node
    %     elseif isempty(index_resp_node) == 1
    %        resp_node = nodes(1);
    %     end
    % end
    
    targets(ii,1)=O_p;
    
    msg_1 = ['N_r=', num2str(N_r), ' searches for O_p=', num2str(O_p), ' with alpha=', num2str(alpha),' and delta=', num2str(delta),'.'];
    disp(msg_1)
    disp(' ');
    
    [N_t, hops_dist, hops_priv, upper_bounds, random_dist, node_addresses, object_addresses, random_addresses]=Iris(nodes, N_r, O_p, delta, alpha, routing_tables, m, n_nodes, d_nodes, mal_nodes);
    dist_N2Op(ii,:)=hops_dist;
    priv_data(ii,:)=hops_priv;
    ub_data(ii,:)=upper_bounds;
    dist_N2Ir(ii,:)=random_dist;
    addresses_of_nodes(ii,:)=node_addresses;
    addresses_of_objects(ii,:)=object_addresses;
    random_points(ii,:)=random_addresses;

    end

keepvars = {'number_of_nodes','length_of_IdSpace','number_of_experiments','jj','name','targets','addresses_of_nodes','addresses_of_objects','random_points','dist_N2Op','dist_N2Ir','priv_data','ub_data'};
clearvars('-except', keepvars{:});

% Define the name of the file to save the variables of the experiments
% For our files we follow the convention 'test_expA_nB_aC_dD_attE.mat' where:
% A: the number of experiments executed,
% B: the number of participating nodes in the network
% C/D: the alpha and delta value used
% E: the fraction of colluding nodes
file_name = ['test_exp500_n1000_a025_d14_att' name '.mat'];
save(file_name)

end