t = tiledlayout(5,1);
t.TileSpacing = 'tight';

f1=nexttile;
data_1 = load("pr_data_att00.csv");
h1 = histogram(data_1, 'Normalization','count');
h1.BinWidth=0.01;
% h1.NumBins = 30;
h1.FaceColor = '#0072BD';
h1.BinEdges = h1.BinEdges + h1.BinWidth/2;
h1.BinLimits=[0.2 1];
h1.DisplayName = sprintf('$~~~f=%d$\\%%',0);
hold on
a = 0.25;
% x1 = xline(a,'--','Color','#7E2F8E','Label',{sprintf('$\\alpha=%.2f$',a)},'FontSize',8,'Interpreter','latex','LabelHorizontalAlignment','center', 'LabelVerticalAlignment','middle');
x1 = xline(a,'-','Color','#7E2F8E');

l1 = legend(h1.DisplayName,'');
set(l1, 'FontSize',12,'Interpreter','latex')

f2=nexttile;
data_2 = load("pr_data_att18.csv");
h2 = histogram(data_2, 'Normalization','count');
h2.BinWidth=0.01;
% h1.NumBins = 30;
h2.FaceColor = '#D95319';
h2.BinEdges = h2.BinEdges + h2.BinWidth/2;
h1.BinLimits=[0.2 1];
h2.DisplayName = sprintf('$f=%.1f$\\%%',12.5);
hold on
a = 0.25;
% x2 = xline(a,'--','Color','#7E2F8E','Label',{sprintf('$\\alpha=%.2f$',a)},'FontSize',8,'Interpreter','latex','LabelHorizontalAlignment','center', 'LabelVerticalAlignment','middle');
x2 = xline(a,'-','Color','#7E2F8E');
l2 = legend(h2.DisplayName,'');
set(l2, 'FontSize',12,'Interpreter','latex')

f3=nexttile;
data_3 = load("pr_data_att16.csv");
h3 = histogram(data_3, 'Normalization','count');
h3.BinWidth=0.01;
% h1.NumBins = 30;
h3.FaceColor = '#EDB120';
h3.BinEdges = h3.BinEdges + h3.BinWidth/2;
h1.BinLimits=[0.2 1];
h3.DisplayName = sprintf('$f=%.1f$\\%%',16.7);
hold on
a = 0.25;
% x3 = xline(a,'--','Color','#7E2F8E','Label',{sprintf('$\\alpha=%.2f$',a)},'FontSize',8,'Interpreter','latex','LabelHorizontalAlignment','center', 'LabelVerticalAlignment','middle');
x3 = xline(a,'-','Color','#7E2F8E');
l3 = legend(h3.DisplayName,'');
set(l3, 'FontSize',12,'Interpreter','latex')

f4=nexttile;
data_4 = load("pr_data_att13.csv");
h4 = histogram(data_4, 'Normalization','count');
h4.BinWidth=0.01;
% h1.NumBins = 30;
h4.FaceColor = '#77AC30';
h4.BinEdges = h4.BinEdges + h4.BinWidth/2;
h1.BinLimits=[0.2 1];
h4.DisplayName = sprintf('$f=%.1f$\\%%',33.3);
hold on
a = 0.25;
% x4 = xline(a,'--','Color','#7E2F8E','Label',{sprintf('$\\alpha=%.2f$',a)},'FontSize',8,'Interpreter','latex','LabelHorizontalAlignment','center', 'LabelVerticalAlignment','middle');
x4 = xline(a,'-','Color','#7E2F8E');
l4 = legend(h4.DisplayName,'');
set(l4, 'FontSize',12,'Interpreter','latex')

f5=nexttile;
data_5 = load("pr_data_att12.csv");
h5 = histogram(data_5, 'Normalization','count');
h5.BinWidth=0.01;
% h1.NumBins = 30;
h5.FaceColor = '#A2142F';
h5.BinEdges = h5.BinEdges + h5.BinWidth/2;
h1.BinLimits=[0.2 1];
h5.DisplayName = sprintf('$~~f=%d$\\%%',50);
hold on
a = 0.25;
% x5 = xline(a,'--','Color','#7E2F8E','Label',{sprintf('$\\alpha=%.2f$',a)},'FontSize',8,'Interpreter','latex','LabelHorizontalAlignment','center', 'LabelVerticalAlignment','middle');
x5 = xline(a,'-','Color','#7E2F8E');
l5 = legend(h5.DisplayName,'');
set(l5, 'FontSize',12,'Interpreter','latex')

linkaxes([f1 f2 f3 f4 f5],'xy')
xlabel(t,'privacy ratio')
ylabel(t,'count')