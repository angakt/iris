function [d] = Distance(I_i, I_j, m)

if I_j >= I_i
    d = I_j-I_i;
else
    d = 2^m-I_i+I_j; 
end