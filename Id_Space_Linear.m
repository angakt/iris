function [m, n_nodes, nodes, routing_tables, predecessors, dist_nodes, attackers] = Id_Space_Linear(m, n_nodes)

% clear;
% % clf; 
% clc;

% Initialize address space.
% m = 23;
% space = 1:1:2^m; % the total number of points (or linspace(0,2^m,(2^m-1)))
% n_nodes = 1000; % number of nodes in the network
% n_objects = 5600000; % number of objects in the network
% d_nodes = round(max(space)/n_nodes); % the distance among nodes
% d_objects = round(max(space)/n_objects); % the distance among objects


%%% The nodes in the network, generate n_nodes random numbers in the interval [a,b] 
a = 1;
b = 2^m;
nodes = round(a + (b-a).*rand(n_nodes,1));

%%% Omit the repetitive values 
nodes = unique(nodes);

while size(nodes,1)~=n_nodes
    n_rem_nodes = n_nodes-size(nodes,1);
    nodes2add = round(a + (b-a).*rand(n_rem_nodes,1));
    nodes2add = unique(nodes2add);
    nodes = cat(1,nodes,nodes2add);
    nodes = unique(nodes);
end

nodes = sort(nodes,1);

% nodes = zeros(1,n_nodes); % Preallocating memory
% for ii=1:n_nodes
%%%  attackers f=0 %%%
%     nx = ii*d_nodes;  % on average we have this not everyone
%     if le(nx,2500) 
%     plot(nx, 0, 'o', 'LineWidth', 2, 'MarkerSize', 15, 'MarkerEdgeColor','#A2142F', 'MarkerFaceColor','#A2142F');
%     t = text(nx,0,num2str(nx));
%     t.Color = [0 0 0];
%     t.HorizontalAlignment = 'center';
%     end
%     if le(nx,max(space)) 
%         nodes(ii) = nx;
%     end
% end

% The objects in the network
% objects = zeros(1,n_objects);
% for ii=1:n_objects
%     obx = ii*d_objects;
% %     if le(obx,2500)
% %     plot(obx, 0, 's', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerEdgeColor','#EDB120', 'MarkerFaceColor','#EDB120');
% %     t = text(obx,0,num2str(obx));
% %     t.Color = [0 0 0];
% %     t.HorizontalAlignment = 'center';
% %     end
%     if le(obx,max(space)) 
%         objects(ii) = obx;
%     end
% end

% A = [0 0];
% B = [max(space) 0];
% % plot(A,B,'b*')
% axis([-10 max(space)+10 -1 1])
% line(B,A);
% hold off

% The object tables
% avr = round(n_objects/n_nodes); % Average number of objects assigned to each node
% object_tables = zeros(n_nodes, (2*avr+2)); % Allocate the memory for the Object Table 
% 
% for ii=1:n_nodes
%     object_tables(ii,1) = nodes(ii); % Fill the first column of the Object Table with the node_ids that exist in the network 
% end
% 
% for ii=1:n_objects
%     c1 = find(nodes>=objects(ii),1); % The index of the responsible node
%     if isempty(c1) == 0
%         resp_node = nodes(c1); % The responsible node
%         resp_cell2fill = find(object_tables(c1,:)==0,1); % Which column of the Object Table to fill
%         object_tables(c1,resp_cell2fill) = objects(ii); % Which cell of the Object Table to fill
%     % A circlular address space
%     % FIX: with else it is deleting the values
%     elseif isempty(c1) == 1
%         resp_node = nodes(1);
%         resp_cell2fill = find(object_tables(1,:)==0,1);
%         object_tables(1,resp_cell2fill) = objects(ii);
%     end
% end

% The routing tables  
routing_tables = zeros(n_nodes, m+1);

for ii=1:n_nodes
    routing_tables(ii,1) = nodes(ii);
    routing_tables(ii,2+m) = nodes(ii);
end

for ii=1:n_nodes
%     msg_0 = [num2str(nodes(ii))];
%     disp(msg_0)
%     disp(' ');
    for jj=1:m
        ref_point = nodes(ii)+2^(jj-1);
        c2 = find(nodes>=mod(ref_point,2^m),1);
%         msg_1 = [num2str(nodes(ii)), '+', num2str(2^(jj-1)), '=', num2str(ref_point)];
%         disp(msg_1)
%         disp(' ');
        try
            routing_tables(ii,(jj+1)) = nodes(c2);
        catch
%%%%          A circular address space
%             msg_1 = [num2str(nodes(ii)), '+', num2str(2^(jj-1)), '=', num2str(ref_point)];
%             disp(msg_1)
%             disp(' ');
            routing_tables(ii,(jj+1)) = nodes(1);
        end
    end
end

% The predesessors  
predecessors = zeros(n_nodes, 2);

for ii=1:n_nodes
    predecessors(ii,1) = nodes(ii);
end

for ii=1:n_nodes
    c3 = find(nodes<nodes(ii),1,'last');
    try
        predecessors(ii,2) = nodes(c3);
    catch
        predecessors(ii,2) = nodes(n_nodes);
    end
end

dist_nodes = Node_Dist(m, n_nodes, routing_tables, predecessors);

% The attackers
attackers = zeros(5, n_nodes);
%%% No attackers
attackers(1,:) = 0;

%%% Fraction=1/2
n_attackers_12 = round((1/2)*n_nodes);
id_attackers_12 = randperm(length(nodes),n_attackers_12);
attackers_12 = sort(nodes(id_attackers_12));
for ii=1:numel(attackers_12)
    attackers(2,ii) = attackers_12(ii);
end
%%% Fraction=1/3
n_attackers_13 = round((1/3)*n_nodes);
id_attackers_13 = randperm(length(nodes),n_attackers_13);
attackers_13 = sort(nodes(id_attackers_13));
for ii=1:numel(attackers_13)
    attackers(3,ii) = attackers_13(ii);
end
%%% Fraction=1/6
n_attackers_16 = round((1/6)*n_nodes);
id_attackers_16 = randperm(length(nodes),n_attackers_16);
attackers_16 = sort(nodes(id_attackers_16));
for ii=1:numel(attackers_16)
    attackers(4,ii) = attackers_16(ii);
end
%%% Fraction=1/8
n_attackers_18 = round((1/8)*n_nodes);
id_attackers_18 = randperm(length(nodes),n_attackers_18);
attackers_18 = sort(nodes(id_attackers_18));
for ii=1:numel(attackers_18)
    attackers(5,ii) = attackers_18(ii);
end

keepvars = {'m', 'n_nodes', 'nodes', 'routing_tables', 'predecessors', 'dist_nodes', 'attackers'};
clearvars('-except', keepvars{:});
% save('test.mat');