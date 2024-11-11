% Script to calculate the distance (normalized by delta) of
% every queried node to the Random point and the target.
% The distances are plotted in a figure as histograms 
% and saved into two csv files.

clear;
clc;
load('test_exp500_n1000_a075_d1128_att00.mat');
m=23;
n_exp = size(addresses_of_nodes,1);

for ii=1:n_exp
    zero_index = find(addresses_of_nodes(ii,:)==0,1);
    nodeIDs = addresses_of_nodes(ii,2:(zero_index-2));
    n_nodes = size(nodeIDs,2);
    for jj=1:n_nodes
        R(ii,jj) = Distance(nodeIDs(jj),random_points(ii,jj),m);
        Op(ii,jj) = Distance(nodeIDs(jj),targets(ii),m);
        delta(ii,jj) = Distance(nodeIDs(jj),ub_data(ii,jj),m);
        data_O(ii,jj) = (Op(ii,jj)/delta(ii,jj))*100;
        data_R(ii,jj) = (R(ii,jj)/delta(ii,jj))*100;
        if data_R(ii,jj)==0
            disp('R=0')
        end
    end
end

not_zero_data_O = data_O > 0;
h1 = histogram(data_O(not_zero_data_O), 'Normalization','count');
h1.BinWidth=2;
h1.BinEdges = h1.BinEdges + h1.BinWidth/2;
h1.BinLimits=[-1 101];
hold on
not_zero_data_R = data_R > 0;
h2 = histogram(data_R(not_zero_data_R), 'Normalization','count');
h2.BinWidth=2;
h2.BinEdges = h2.BinEdges + h2.BinWidth/2;
h2.BinLimits=[-1 101];

hold off
grid on
% axis([-1 120 0 1])
xlabel('Distance');
ylabel('Count');
legend('o*100/UB','r*100/UB','Location','northeast')

R = data_R(not_zero_data_R);
%% when using Octave
csvwrite('data_R.csv',R)
%% when using Matlab
% writematrix(R,'data_R.csv')

O = data_O(not_zero_data_O);
%% when using Octave
csvwrite(O,'data_O.csv')
%% when using Matlab
% writematrix(O,'data_O.csv')