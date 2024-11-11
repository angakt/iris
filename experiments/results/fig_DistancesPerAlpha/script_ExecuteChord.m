% Execute Chord given the addresses of requesters and targets

clear;
clc;

chord_distancesN2Op = zeros(1,100);

load('test_exp100_n1000_a025_d116_att00');
number_of_experiments = 100;

for ii=1:number_of_experiments
    % Load the variables of the id_space
    number_of_nodes=1000;
    load(['experiments/networks/' num2str(number_of_nodes) '_nodes/AddressSpace' num2str(ii) '.mat'])
    O_p = targets(ii);
    N_r = addresses_of_nodes(ii,1);

    N_0 = Chord_Lookup(N_r, O_p, routing_tables, m);
    chord_distancesN2Op(ii,1) = Distance(N_0, O_p, m);

    N_n = Chord_Lookup(N_0, O_p, routing_tables, m);

    jj=2;

    % We use Op-1 in case the target is a node id
    if O_p>=N_0
        pointss = N_0:1:(O_p-1);
    else
        space = 1:1:2^m;
        exclude = (O_p-1):1:N_0;
        pointss = setdiff(space,exclude);
    end

    while ismember(N_n,pointss)==true
        chord_distancesN2Op(ii,jj) = Distance(N_n, O_p, m);
        [N_n] = Chord_Lookup(N_n, O_p, routing_tables, m);
        jj=jj+1;
    end
end

    %% when using Octave
    csvwrite("data_a1.csv", chord_distancesN2Op)
    %% when using Matlab
    % writematrix(chord_distancesN2Op,'data_a1.csv');
