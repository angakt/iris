function [N_q] = Chord_Lookup(N, I, routing_tables, m, opt)

% The option is used if we want to find
% the N0 with the Chord_Lookup function
if exist('opt', 'var')
    opt = true;
elseif ~exist('opt', 'var')
    opt = false;
end

node_index = find(routing_tables==N,1);

for ii=1:m+1 % The first successor is indexed at 2    
    S = sort([I,routing_tables(node_index,ii),routing_tables(node_index,ii+1)]);
    if routing_tables(node_index,ii)==routing_tables(node_index,ii+1)
        continue
    end
    if S(1) == routing_tables(node_index,ii) && S(2) == I && S(3) == routing_tables(node_index,ii+1)    
        if ii==1
            if opt==true
                N_q = routing_tables(node_index,m+1);
                break
            end
            N_q = routing_tables(node_index,ii+1);
            msg_1 = [num2str(N),':The responsible node of ', num2str(I), ' is node ', num2str(N_q),'.'];
            disp(msg_1)
        else
            N_q = routing_tables(node_index,ii);
            msg_2 = [num2str(N),':I do not know, you can ask node ', num2str(N_q), '.'];
            disp(msg_2)
        end
        break
    elseif S(1) == routing_tables(node_index,ii+1) && S(2) == routing_tables(node_index,ii) && S(3) == I
        if ii==1
            if opt==true
                N_q = routing_tables(node_index,m+1);
                break
            end
            N_q = routing_tables(node_index,ii+1);
            msg_3 = [num2str(N),':The responsible node of ', num2str(I), ' is node ', num2str(N_q),'.'];
            disp(msg_3)
        else
            N_q = routing_tables(node_index,ii);
            msg_4 = [num2str(N),':I do not know, you can ask node ', num2str(N_q), '.'];
            disp(msg_4)
        end
        break
    elseif S(1) == I && S(2) == routing_tables(node_index,ii+1) && S(3) == routing_tables(node_index,ii)
        if ii==1
            if opt==true
                N_q = routing_tables(node_index,m+1);
                break
            end
            N_q = routing_tables(node_index,ii+1);
            msg_5 = [num2str(N),':The responsible node of ', num2str(I), ' is node ', num2str(N_q),'.'];
            disp(msg_5)
        else
            N_q = routing_tables(node_index,ii);
            msg_6 = [num2str(N),':I do not know, you can ask node ', num2str(N_q), '.'];
            disp(msg_6)
        end
        break
    end
end