% The script loads the privacy data of 500 experiments of a specified
% fraction of colluding nodes and finds the min privacy ratio of every experiment

clear;
clc;

for jj=1:5

    switch jj
        case 1
            name = '00';
        case 2
            name = '12';
        case 3
            name = '13';
        case 4
            name = '16';
        case 5
            name = '18';
        otherwise
            disp('more loops than defined attacker fractions')
    end

    file_name = ['test_exp500_n1000_a025_d14_att' name '.mat'];
    load(file_name);
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
    
    pr_file_name = ['pr_data_att' name '.csv'];

    %% when using Octave
    csvwrite(pr_file_name,priv_row_min)
    %% when using Matlab
    % writematrix(priv_row_min,pr_file_name)

    keepvars = {'jj'};
    clearvars('-except', keepvars{:});
end