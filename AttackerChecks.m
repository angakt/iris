function [UB] = AttackerChecks(attacker_data, N_q, UB_q, m)

for ii=1:size(attacker_data,1)

    % S = sort([N_q,UB_q,attacker_data(ii,2)]);
    % if S(1) == N_q && S(2) == attacker_data(ii,2) && S(3) == UB_q
    %     UB=attacker_data(ii,2);
    %     break
    % elseif S(1) == UB_q && S(2) == N_q && S(3) == attacker_data(ii,2)
    %     UB=attacker_data(ii,2);
    %     break
    % elseif S(1) == attacker_data(ii,2) && S(2) == UB_q && S(3) == N_q
    %     UB=attacker_data(ii,2);
    %     break
    % end

    if Distance(N_q, UB_q, m)>Distance(N_q, attacker_data(ii,2), m)
        UB=attacker_data(ii,2);
        break % The attackers' data are sorted based on the queried order
    else
        UB=UB_q;
    end

end