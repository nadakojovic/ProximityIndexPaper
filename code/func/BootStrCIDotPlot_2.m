function [HandeBars] = BootStrCIDotPlot_2(x,y,Col,Col2,Alpha)
    
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
    HandeBars = plot(x,yMean,'color',Col);
    pH = arrayfun(@(x) allchild(x),HandeBars);
    set(pH,'FaceAlpha',Alpha);
    hold on
elseif (sum(size(y) == 1) > 0) & (length(y) == length(x))
    [yMean, yCI] = GetBootstrapCI(y,0.05,1);
    HandeBars = plot(x,yMean,'o','color',Col,markersize=10);
    pH = arrayfun(@(x) allchild(x),HandeBars);
    set(pH,'FaceAlpha',Alpha);
    hold on
else
    
    [yMean, yStd] = GetBootstrapCI(y);
    ySE = yStd-yMean;
    HandeBars = plot(x,yMean,'o','markerfacecolor',Col,'markeredgecolor',Col2,markersize=10);
    hold on
    %errorbar(x,yMean, ySE,'.','color','k','markerfacecolor',Col,'markeredgecolor',Col)
    errorbar(x,yMean, ySE(1,:),ySE(2,:),'o','color','k','markerfacecolor',Col,'markeredgecolor',Col2)
    %pH = arrayfun(@(x) allchild(x),HandeBars);
    %set(pH,'FaceAlpha',Alpha);
    % set(gca,'xticklabel', XLabels)
end

% line([x x], [yMean-ySE yMean+ySE])

end



