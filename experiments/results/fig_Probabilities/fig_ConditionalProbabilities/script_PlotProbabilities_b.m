% The script loads the csv files that have been created with the
% fig_Probabilities\fig_DistancesNormalizedByDelta.m script
% it then calculates and plots as histograms the probabilities P(O|R)
% for a specific value of the target Op

clear;
clc;

Op = 35;
R_values = load("data_R.csv");
O_values = load("data_O.csv");

jj = 1;

for r=0:(Op-1)
    c = 0;
    for ii=1:size(R_values,1)
        if (r-0.5)<=R_values(ii) && (R_values(ii)<(r+0.5))
        % if (R_values(ii)<(r+0.5))
            data(jj,r+1) = O_values(ii);            
            jj=jj+1;
        end
    end    
    column_data = data(:,r+1);
    not_zero_data = column_data>0;
    N = size(column_data(not_zero_data),1);
    for kk=1:N
        % if (Op-0.5)<=column_data(kk) && (column_data(kk)<(Op+0.5))
        if (column_data(kk)<(Op+0.5))
            c = c+1;
        end
    end
    prob(r+1,1)=c/N;
    jj = 1;
end

x1 = linspace(0,Op-1,Op);

hold on 

bar(x1, prob);


% % Probability for Op=o given R=r
% y1 = (1./(100-x1));

% % Probability for Op<=o given R=r
y1 = ((Op-x1)./(100-x1));

% Probability for Op=o given R<=r
% y1 = (2./(2*100-x1-1));

% % Probability for Op<=o given R<=r
% y1 = (2*Op-x1-1)./(2*100-x1-1);

p = plot(x1,y1,'Color','#EDB120');
p.LineWidth = 1.5;

x2 = Op-1;
xline(x2,'--','Color','#D95319');

% xticks(Op-1)
% xticklabels({sprintf('$x=%d$', Op-1)})
% xaxisproperties= get(gca, 'XAxis');
% xaxisproperties.TickLabelInterpreter = 'latex';

% xline(x2,'--','Color','#D95319','Label',{sprintf('${O_{p}-1}=%d$', x2)},'FontSize',12,'Interpreter','latex','LabelHorizontalAlignment','center', 'LabelVerticalAlignment','top');

% x3 = 100;
% xline(x3,'--','Color','#77AC30','Label',{sprintf('$\\delta=%d$',x3)},'FontSize',12,'Interpreter','latex','LabelHorizontalAlignment','center', 'LabelVerticalAlignment','middle');

hold off
grid on
axis([-1 100 0 1])
xlabel('Random Point');
ylabel('Probability');
legend('Sample Data','Fitted Probability','${R_i}$ Upper Limit','Location','northeast','Interpreter','latex')
% legend('Sample Data','Fitted Probability','Upper Limit for {I_r}','Upper Bound','Location','northeast','NumColumns',2)