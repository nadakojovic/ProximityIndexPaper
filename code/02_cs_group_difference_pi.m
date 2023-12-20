clear all
close all
addpath(genpath('./code'))
% Load Proximity Index Data
load('pi_td_loo.mat'); % Proximity index for the TD group (obtained using the Leave One Out (LOO) method)
load('pi_asd.mat');    % Proximity index for the ASD group

% Calculate Mean Proximity Index Values
mean_pi_asd = nanmean(pi_asd_allsubjects, 2);
mean_pi_td = nanmean(pi_td_loo, 2);

%% T-test and Plotting

% Perform two-sample t-test
[h, p, ci, stats] = ttest2(mean_pi_td, mean_pi_asd);

% Create a figure for plotting
figure('color', 'w', 'units', 'centimeters', 'position', [0 0 15 15]);

% Plotting Violin and Dot Plots for TD and ASD Groups
VertViolinPlot(1, mean_pi_td, ones(size(mean_pi_td)), [0 0 1], .3);
BootStrCIDotPlot(1, mean_pi_td, [0 0 .9], 0.05);
VertViolinPlot(2, mean_pi_asd, ones(size(mean_pi_asd)), [1 0 0], .3);
BootStrCIDotPlot(2, mean_pi_asd, [.9 0 0], 0.05);

% Customize the plot
set(gca, 'xtick', [1 2], 'xticklabel', {'TD', 'ASD'})
xlabel('');
ylabel('Proximity Index');
xlim([0 3]);
text(2.8, max(mean_pi_td) + 0.07, ['\itt\rm(' num2str(stats.df) ') = ' num2str(round(stats.tstat, 2)) ...
    newline '\itp \rm < 0.001'], 'HorizontalAlignment', 'right');

% Additional plot settings
set(gca, 'box', 'off');
set(gca, 'Color', 'None');
set(gca, 'TickLength', [.005 0.005]);
ylabel({'Mean proximity index'});
set(gca, 'FontName', 'Helvetica Neue', 'FontSize', 12, 'FontWeight', 'bold');

% Save the figure
fig_name = strcat('cs_pi_group_diff', '.pdf');
exportgraphics(gca, fig_name, 'BackgroundColor', 'none');
