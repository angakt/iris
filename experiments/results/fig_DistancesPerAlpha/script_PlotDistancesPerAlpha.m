% The script loads the distance data from different executions with the same alpha
% and plots the average distances across 100 executions on every step

clf;
clc;
clear;

numfiles = 5;
mydata = cell(1, numfiles);

for k = 1:numfiles
    myfilename = sprintf('data_a%d.csv', k);
    mydata{k} = importdata(myfilename);
    msg_0 = ['Done loading file_', num2str(k), '.'];
    disp(msg_0)
    
    data = ceil(mean(mydata{1,k}));
    
    % Plot only no zero values
    plot_data = data(:,1:100);    
    
    % Normalize the distances to the delta value
    delta = 2^23/16;

    p(k) = plot(0:length(plot_data) - 1, plot_data/delta);

    x0 = find(data == 0,1);
    xline(x0,'--','Color',p(k).Color,'Label',{sprintf('$x=%d$',x0)},'FontSize',12,'LabelHorizontalAlignment','center', 'LabelVerticalAlignment','middle','Interpreter','latex');
    
    xx = xlabel('$N^o$ \it {Iterations (n)}','interpreter','latex');
    xx.FontSize = 20;

    yy = ylabel('Distance to $O_p$ ($d_n$)','interpreter','latex');
    yy.FontSize = 20;

    hold on

    legend({'\it {Chord}','','$\alpha=0.25$','','$\alpha=0.35$','','$\alpha=0.50$','','$\alpha=0.75$'},'TextColor','black','FontSize',15,'Interpreter','latex')
end

threshold = xline(log2(1000),'-',{sprintf('$log_2(N)\\approx%d$',round(log2(1000)))},'FontSize',10,'LabelHorizontalAlignment','right', 'LabelVerticalAlignment','top','HandleVisibility','off','Interpreter','latex');

hold off