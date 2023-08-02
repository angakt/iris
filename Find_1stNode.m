function [N_0] = Find_1stNode(N_r, I_start, O_p, routing_tables, m)

% N -> the requester
% I -> the starting point of the search

node_index = find(routing_tables==N_r,1);

for ii=2:m+1 % The first successor is indexed at 2
    if routing_tables(node_index,ii)==routing_tables(node_index,ii+1)
        continue
    end    
    S = sort([I_start,routing_tables(node_index,ii),O_p]);
    if S(1) == I_start && S(2) == routing_tables(node_index,ii) && S(3) == O_p    
        N_0 = routing_tables(node_index,ii);
        msg_1 = ['The search starts by asking node ', num2str(N_0), '.'];
        disp(msg_1)
        break           
    elseif S(1) == O_p && S(2) == I_start && S(3) == routing_tables(node_index,ii)
        N_0 = routing_tables(node_index,ii);
        msg_2 = ['The search starts by asking node ', num2str(N_0), '.'];
        disp(msg_2)
        break  
    elseif S(1) == routing_tables(node_index,ii) && S(2) == O_p && S(3) == I_start
        N_0 = routing_tables(node_index,ii);
        msg_3 = ['The search starts by asking node ', num2str(N_0), '.'];
        disp(msg_3)
        break
    end
    break
end