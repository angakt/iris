% The script loads the privacy data of 100 experiments of a specified
% fraction of colluding nodes and finds the min privacy ratio of every experiment

clear;
clc;

load('test_exp500_n1000_a025_d64_att18.mat');
priv_ratios=priv_data;

% priv_ratios=load("selected_pr_data_att18.csv");

% Taking the min
% priv_min = min(priv_data);
% writematrix(priv_min,'pr_data_a3.csv')

% Taking the mean
% priv_avg = mean(priv_data);
% writematrix(priv_avg,'pr_data_a31.csv')

% Taking the row min
B = sort(priv_ratios,2);
priv_row_min=zeros(size(B,1),1); % initialize the matrix for minimum values
for ii=1:size(B,1)
    k = find(B(ii,:)>0,1);
    priv_row_min(ii)=B(ii,k);
end

writematrix(priv_row_min,'pr_data_att18.csv')