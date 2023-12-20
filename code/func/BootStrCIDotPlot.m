
% This function plots a dot graph based on input data, with the option to
% include bootstrap confidence intervals.
% Inputs:
%   x - A vector containing the x-axis values for the plot. If not provided,
%       the function will use the index of the y values as the x-axis values.
%   y - A vector or matrix containing the y-axis values to be plotted.
%   Col - RGB color value for the dots. Default is a shade of blue ([.3 .3 1]).
%   Alpha - Alpha value for the dot color, controlling its transparency.
%          Default is 1 (opaque).
%
% Outputs:
%   HandeBars - A plot handle for the generated dot plot. This can be used
%               for further customization of the plot after the function call.
%
% Usage:
%   [HandeBars] = BootStrCIDotPlot(x, y); % Basic usage with x and y data.
%   [HandeBars] = BootStrCIDotPlot(x, y, [.3 .3 1], 1); % Full usage.
%
% Note:
%   The function requires the 'GetBootstrapCI' function to calculate
%   the confidence intervals. Ensure this function is available in your path.
% Author:
% S.H. Castañón




function [HandeBars] = BootStrCIDotPlot(x,y,Col,Alpha)

if nargin < 2
    y = x;
    x = size(y,2);
end

if nargin < 3
    Col = [.3 .3 1];
end

if nargin < 4
    Alpha = 1;
end



if (numel(y) == 1) & (numel(x) == 1)
    yMean = y;
    HandeBars = plot(x,yMean,'color',Col,'LineWidth',2);
    pH = arrayfun(@(x) allchild(x),HandeBars);
    set(pH,'FaceAlpha',Alpha);
    hold on
elseif (sum(size(y) == 1) > 0) & (length(y) == length(x))
    [yMean, yCI] = GetBootstrapCI(y,0.05,1);
    HandeBars = plot(x,yMean,'o','color',Col,'LineWidth',2);
    pH = arrayfun(@(x) allchild(x),HandeBars);
    set(pH,'FaceAlpha',Alpha);
    hold on
else

    [yMean, yStd] = GetBootstrapCI(y);
    ySE = yStd-yMean;
    HandeBars = plot(x,yMean,'o','markerfacecolor',Col,'markeredgecolor','k','MarkerSize',10,'LineWidth',2);
    hold on
    %errorbar(x,yMean, ySE,'.','color','k','markerfacecolor',Col,'markeredgecolor',Col)
    errorbar(x,yMean, ySE(1,:),ySE(2,:),'o','color','k','markerfacecolor',Col,'markeredgecolor','k','LineWidth',2)
    %pH = arrayfun(@(x) allchild(x),HandeBars);
    %set(pH,'FaceAlpha',Alpha);
    % set(gca,'xticklabel', XLabels)
end

% line([x x], [yMean-ySE yMean+ySE])

end
