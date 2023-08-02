function [p, UB_q, attacker_data] = Privacy(N_q, I_q, delta, m, attacker_data, mal_nodes, O_p)

UB_q = mod(N_q+delta,2^m);

%%% check if we have colluding attackers %%%
check=ismember(N_q, mal_nodes);

if check==1
    msg = 'This is one of the colluding nodes!:(';
    disp(msg)

    %%% applying the attack only for the colluding nodes
    %%% that infer the UB correctly
    d1=Distance(N_q, O_p, m);
    d2=Distance(N_q, UB_q, m);
    if d1<=delta
        if d1<d2
            %%%% --- %%%%
            cell2fill = find(~attacker_data,1);
            attacker_data(cell2fill,1)=N_q;
            attacker_data(cell2fill,2)=UB_q;
            if cell2fill>1
                UB_q=AttackerChecks(attacker_data, N_q, UB_q, m);        
            end
            %%%% --- %%%%
        end
    end
elseif check==0
    msg1 = 'This is not one of the colluding nodes!:)';
    disp(msg1)
end


% S = sort([N_q, I_q, UB_q]);
% if S(1) == N_q && S(2) == I_q && S(3) == UB_q 
%     prior = UB_q - N_q;
%     posterior = UB_q - I_q;
% elseif S(1) == UB_q && S(2) == N_q && S(3) == I_q 
%     prior = 2^m-(N_q - UB_q);
%     posterior = 2^m-(I_q - UB_q);
% elseif S(1) == I_q && S(2) == UB_q && S(3) == N_q
%     prior = 2^m-(N_q - UB_q);
%     posterior = UB_q - I_q;
% else
%     msg_1 = ['N_q=', num2str(N_q), ', I_q=', num2str(I_q), ', UB_q=',num2str(UB_q)];
%     disp(msg_1)
%     disp(' ');
%     prior = 1;
%     posterior = 0;
% %     error('Error. Sth is going wrong with the sorting.')
% end

prior = Distance(N_q, UB_q, m);
posterior = Distance(I_q, UB_q, m);
p = posterior/prior;

msg = ['The privacy against node:',num2str(N_q), ', which has UB=', num2str(UB_q),', when queried for identifier:', num2str(I_q), ' is ', num2str(p)];
disp(msg)