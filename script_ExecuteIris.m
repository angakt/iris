% The script runs ii the Iris algorithm and saves the execution data to a file. 
% Between execution the alpha and delta parameters and attackers' fraction remain stable
% but the id_space, the requester node N_r and the target addres O_p change.
% N_r and O_p are chosen uniformly at random from the registered nodes and the id_space, respectiverly.

clear;
clc;

dist_N2Op = zeros(500,100);
dist_N2Ir = zeros(500,100);
priv_data = zeros(500,100);
ub_data = zeros(500,100);
addresses_of_nodes = zeros(500,100);
addresses_of_objects = zeros(500,100);
random_points = zeros(500,100);
targets = zeros(500,1);

for ii=1:500

    % Load the variables of the id_space
    number_of_nodes=1000;
    % file_number= jj*number_of_nodes;

    % For linux
    % load(['experiments/2nd round/' num2str(file_number) '_nodes.mat'])
    % For windows
    % load(['experiments\2nd round\' num2str(file_number) '_nodes.mat'])
    load(['experiments\networks\' num2str(number_of_nodes) '_nodes\AddressSpace' num2str(ii) '.mat'])
    msg_0 = [newline '%%% Done loading file ', num2str(ii), ' %%%'];
    disp(msg_0)
    disp(' ');

    % alpha = 0;
    alpha = 0.25;
    % alpha = 0.35;
    % alpha = 0.50;
    % alpha = 0.75;

    % delta = 2^23/4;
    % delta = 2^23/8;
    % delta = 2^23/16;
    % delta = 2^23/32;
    delta = 2^23/64;
    % delta = 2^23/128;
    % delta = 2^23/256;
    % delta = 2^23/512;
    % delta = 2^23/1024;
    % delta = 2^23/2048;
    % delta = 2^23/4096;
    % delta = 2^23/8192;
    % delta = 2^23/16384;

    % We have f0,f12,f13,f16,f18
    mal_nodes=attackers(5,:);

    % for ii=1:100

    N_r = nodes(randi(numel(nodes)));
    % Check that the requester is not one of the colluding nodes
    while ismember(N_r, mal_nodes)==1
      % msg = 'We chose another Nr';
      % disp(msg)
      N_r = nodes(randi(numel(nodes)));
    end
    % N_r = nodes(1,1); % We can position the requester as the first node in the net without loss of generality
        
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

    keepvars = {'targets','addresses_of_nodes','addresses_of_objects','random_points','dist_N2Op','dist_N2Ir','priv_data','ub_data'};
    clearvars('-except', keepvars{:});
    save('test_exp500_n1000_a025_d64_att18.mat','') 

%     keepvars = {'file_number','dist_data','priv_data','ub_data'};
%     clearvars('-except', keepvars{:});
%     writematrix(dist_data,['spaces/data_a1_' num2str(file_number) '.csv'])
%     writematrix(dist_N2Op,['data_a1.csv'])
% end