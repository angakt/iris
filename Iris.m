function [N, distancesN2Op, pr_values, UB_values, distancesN2Ir, node_ids, object_ids, random_ids] = Iris(nodes, N_r, O_p, delta, alpha, routing_tables, m, n_nodes, d_nodes, mal_nodes)

% Calculate from where to start the query
if (O_p-delta)>=0
    I_start= O_p-delta;
elseif (O_p-delta)<0
    I_start = 2^m-abs(O_p-delta);
end
% I_start = mod(O_p-delta,2^m);

% Preallocating memory
node_ids = zeros(1,100);
object_ids = zeros(1,100);
random_ids = zeros(1,100);
distancesN2Op = zeros(1,100);
distancesN2Ir = zeros(1,100);
pr_values = zeros(1,100);
UB_values = zeros(1,100);
attacker_data = zeros(n_nodes,2);

node_ids(1,1) = N_r;
object_ids(1,1) = I_start;

% Picking as the first node, the node that the requester knows that
% comes after I_start. If Nr does not know one such node, he picks
% N0 as the first node he knows that precedes I_start
  try
      N_0 = Find_1stNode(N_r, I_start, O_p, routing_tables, m);
  catch
      N_0 = Chord_Lookup(N_r, I_start, routing_tables, m);
  end

% % Picking as the first node the node from the network that
% % comes after I_start
% index_N_0 = find(nodes>=I_start,1);
% if isempty(index_N_0)==0
%     N_0 = nodes(index_N_0);
% else
%     N_0 = nodes(1);
% end

% N_0 = Chord_Lookup(N_r, I_start, routing_tables, m, flag);

node_ids(1,2) = N_0;

[N_n, pr_val_0, attacker_data, distanceN02Op, distanceN02Ir0, I_0, R_0] = Iris_Step(N_0, O_p, alpha, delta, routing_tables, m, attacker_data, mal_nodes);
object_ids(1,2) = I_0;
node_ids(1,3) = N_n;

distancesN2Op(1,1)=distanceN02Op; % Matlab index starts at 1
msg_1 = ['d_0 = ', num2str(distancesN2Op(1,1))];
disp(msg_1)
distancesN2Ir(1,1) = distanceN02Ir0;

random_ids(1,1) = R_0;

pr_values(1,1) = pr_val_0(1,2);
UB_values(1,1) = pr_val_0(1,1);

ii=2;

% We use Op-1 in case the target is a node id
if O_p>=N_0
    pointss = N_0:1:(O_p-1);
else
    space = 1:1:2^m;
    exclude = (O_p-1):1:N_0;
    pointss = setdiff(space,exclude);
end

% while d>=d_nodes
% while N_n<O_p
while ismember(N_n,pointss)==true
    [N_n, pr_val, attacker_data, distanceN2Op, distanceN2Ir, I_n, R_n] = Iris_Step(N_n, O_p, alpha, delta, routing_tables, m, attacker_data, mal_nodes);
    % if ismember(N_n,pointss)==true

        distancesN2Op(1,ii)=distanceN2Op; % Matlab index starts at 1
        msg_3 = ['d_',num2str(ii-1),' = ', num2str(distancesN2Op(1,ii))];
        disp(msg_3)

        distancesN2Ir(1,ii)=distanceN2Ir;

        random_ids(1,ii) = R_n;

        pr_values(1,ii) = pr_val(1,2);
        UB_values(1,ii) = pr_val(1,1);

        object_ids(1,ii+1) = I_n;
        node_ids(1,ii+2) = N_n;

        ii=ii+1;
    % end
end

N=N_n;
