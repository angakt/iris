function [d_nodes] = Node_Dist(m, n_nodes, routing_tables, predecessors)


% The distance every node takes as average distance between nodes   
d_nodes = zeros(n_nodes, 4);

for ii=1:n_nodes
    d_nodes(ii,1) = routing_tables(ii);    
    d_nodes(ii,2) = mod(routing_tables(ii,2) - routing_tables(ii,1),2^m);
    d_nodes(ii,3) = mod(predecessors(ii,1) - predecessors(ii,2),2^m);
    d_nodes(ii,4) = (d_nodes(ii,2)+d_nodes(ii,3))/2;
end

% for ii=1:n_nodes
%     d_nodes(ii,1) = routing_tables(ii,1);
%     sum = 0;
%     for jj=1:(m-1)
%         d_ii = (routing_tables(ii,jj+1)-routing_tables(ii,jj))/2^(jj-1);
%         sum = sum + d_ii;
%     end
%     d_nodes(ii,2) = sum/m;
% end