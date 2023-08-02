% The script loads the distance data from different executions with the same alpha
% and plots the average distances across 100 executions on every step

clf;
clc;
clear;

numfiles = 5;
mydata = cell(1, numfiles);

for k = 1:numfiles
%     myfilename = sprintf('experiments/PlotData/data_b3%d.csv', k);
    myfilename = sprintf('data_a%d.csv', k);
    mydata{k} = importdata(myfilename);
    msg_0 = ['Done loading file_', num2str(k), '.'];
    disp(msg_0)
    
    data = ceil(mean(mydata{1,k}));
    plot_data = data(:,1:100); % Plot only no zero values
    
    % normalizing the distances to the delta value
    % n = 1/4 * (1/2)^(k-1);
    % delta = 2^23*n;
    delta = 2^23/16;

    p = plot(0:length(plot_data) - 1, plot_data/delta);

    % p = plot(0:length(plot_data) - 1, plot_data);

    x0 = find(data == 0,1);
    xline(x0,'--','Color',p.Color,'Label',{sprintf('x=%d',x0)},'FontSize',12,'LabelHorizontalAlignment','center', 'LabelVerticalAlignment','middle');
    
    xx = xlabel('$N^o$ \it {Iterations (n)}','interpreter','latex');
%     xx.Color = '#0072BD';
    xx.FontSize = 20;

    yy = ylabel('Distance to $O_p$ ($d_n$)','interpreter','latex');
    yy.FontSize = 20;

%     t=title('Figure 1','interpreter','latex');
%     t.FontSize = 30;

    hold on

    legend({'{\fontsize{14}Chord}','','{\fontsize{18}\delta}=1/4','','{\fontsize{18}\delta}=1/8','','{\fontsize{18}\delta}=1/16','','{\fontsize{18}\delta}=1/32','',},'TextColor','black','FontSize',15)

    % legend('boxoff') % Remove Legend Background
end

xline(log2(1000),'-',{sprintf('log_2(N)\\approx%d',round(log2(1000)))},'FontSize',10,'LabelHorizontalAlignment','right', 'LabelVerticalAlignment','top','HandleVisibility','off');

hold off