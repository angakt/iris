function [N_j, pr_values, attacker_data, distanceN2Op, distanceN2Ir, I_i, I_r] = Iris_Step(N_i, O_p, alpha, delta, routing_tables, m, attacker_data, mal_nodes)

distanceN2Op=Distance(N_i,O_p,m);

I_r = RandomPoint(N_i, O_p, m);

% Find the queried identifier
dist = Distance(N_i, I_r, m);
dist_i = ceil(alpha*dist);
I_i = I_r-dist_i;
if I_i<0
    I_i=2^m-abs(I_i);
end

distanceN2Ir= Distance(N_i,I_r,m);
% distanceIr2Op = Distance(I_r,O_p,m);

pr_values = zeros(1,2);

[p, UB, attacker_data] = Privacy(N_i, I_i, delta, m, attacker_data, mal_nodes, O_p);

pr_values(1,1) = UB;
pr_values(1,2) = p;

N_j = Chord_Lookup(N_i, I_i, routing_tables, m);