function [I_r] = RandomPoint(N_i, O_p, m)

% space = 1:1:2^m;

% Pick the random reference point.
R = sort([N_i,O_p]);
    if R(2) == O_p
        % samples = N_i:1:(O_p-1);
        a = N_i;
        b = O_p-1;
    elseif R(2) == N_i
        % points = O_p:1:(N_i-1);
        % samples = setdiff(space,points);
        a = N_i;
        b = (O_p-1) + 2^m;
    end

% I_r = samples(randi(numel(samples)));

I_r = round(a + (b-a).*rand(1,1));
if I_r>=2^m
    I_r = I_r - 2^m;
end

% prompt = "Which is the reference point? ";
% I_r = input(prompt);

msg_1 = ['The random point is I_r = ', num2str(I_r)];
disp(msg_1)