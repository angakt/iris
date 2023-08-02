clc;
clear;
load('test_exp500_n1000_a075_d128_att00.mat');

writematrix(addresses_of_nodes,'nodeIDs.csv');
writematrix(random_points,'randomIDs.csv');
writematrix(targets,'targetIDs.csv');
writematrix(ub_data,'upperboundsIDs.csv');
writematrix(addresses_of_objects,'queriedIDs.csv');