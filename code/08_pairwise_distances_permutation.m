
% This script performs an analysis of pairwise distances in gaze data
% between subjects in Typically Developing (TD) and Autism Spectrum Disorder (ASD) groups.
%It uses windowed data to calculate the average pairwise distances and
% compares these distances using permutation tests to determine significant differences.
% Author:
% S.H. Castañón

clear all
close all

addpath(genpath('./code'))


% for p=1:100
%
%     name=sprintf('DISTANCE_WINDOWS_PERMUTED_%02d',p)
%     load(name)
%
%
% num_td_wi=20
% num_as_wi=20
%
% num_kids_wi_permut = size(dist_win_permut,1);
% same_kid_wi  = eye(num_kids_wi_permut);
%
% XXTD_mask_wi = (~same_kid_wi).*1; XXTD_mask_wi(same_kid_wi==1) = nan; XXTD_mask_wi(:,num_td_wi+(1:num_as_wi)) = nan;
% XXAS_mask_wi = (~same_kid_wi).*1; XXAS_mask_wi(same_kid_wi==1) = nan; XXAS_mask_wi(:,1:num_td_wi)  = nan;
% TDXX_mask_wi = (~same_kid_wi).*1; TDXX_mask_wi(same_kid_wi==1) = nan; TDXX_mask_wi(num_td_wi+(1:num_as_wi),:) = nan;
% ASXX_mask_wi = (~same_kid_wi).*1; ASXX_mask_wi(same_kid_wi==1) = nan; ASXX_mask_wi(1:num_td_wi,:)  = nan;
%
%
% TDTD_mask_wi = XXTD_mask_wi.*TDXX_mask_wi;
% ASTD_mask_wi = XXAS_mask_wi.*TDXX_mask_wi;
% TDAS_mask_wi = XXTD_mask_wi.*ASXX_mask_wi;
% ASAS_mask_wi = XXAS_mask_wi.*ASXX_mask_wi;
%
% % Uncomment if you want to see whta the masks look like
% % figure
% % subplot(2,2,1)
% % imagesc([ TDTD_mask_wi  ]),caxis([-1 1])
% % subplot(2,2,2)
% % imagesc([ TDAS_mask_wi  ]),caxis([-1 1])
% % subplot(2,2,3)
% % imagesc([ ASTD_mask_wi  ]),caxis([-1 1])
% % subplot(2,2,4)
% % imagesc([ ASAS_mask_wi  ]),caxis([-1 1])
% % figure('color','w','units','centimeters','position',[0 0 10 10]),
% %
% % %% Make figure of average distance wrt TD and wrt AS
% %
% % figure('color','w','units','centimeters','position',[0 0 10 10]),
%
% avg_dist_win_permut_1= squeeze(nanmean(nanmean(dist_win_permut.*XXTD_mask_wi,2),4));
% avg_dist_win_permut_g1(:,p)=nanmean(avg_dist_win_permut_1(1:num_td_wi,:),1);
%
% avg_dist_win_permut_2 = squeeze(nanmean(nanmean(dist_win_permut.*XXAS_mask_wi,2),4));
% avg_dist_win_permut_g2(:,p)=nanmean(avg_dist_win_permut_2(num_td_wi+(1:num_as_wi),:),1);
% save permutted_pairwise_distances
% end



 load('permutted_pairwise_distances.mat')

%% GROUND TRUTH
% %% find the pairwise distances of gaze locations (with for-loop)
load('sw_td_asd_gaze.mat') %load matrices of gaze data per each window :

%% Compute pairwise distances of gaze locations (framewise)

tic
% number of subjects in the TD and ASD groups for the windowed alldata
num_td_wi = size(sw_td_windows_allgaze,3);
num_as_wi = size(sw_asd_windows_allgaze,3);

gaze_wind = cat(3,sw_td_windows_allgaze(:,:,:,:),sw_asd_windows_allgaze(:,:,:,:));
dims_win = size(gaze_wind);
% prealocate for speed
dist_win = nan(dims_win(3),dims_win(3),dims_win(4),dims_win(2));


toc

tic
num_fr = dims_win(2);
for i_fr = 1:num_fr
    fprintf(['fr = ' num2str(i_fr) newline])
    i_dist_wi = gaze_wind(:,i_fr,:,:)-permute(gaze_wind(:,i_fr,:,:),[1 3 2 4]);
    i_dist_wi = squeeze(sqrt(sum(i_dist_wi.^2,1)));
    dist_win(:,:,:,i_fr) = i_dist_wi;

end
toc

% may choose to save the distance matrices
% save(['ParwiseDistances'  '.mat'],'dist_win')



%% Create masks

% for the windowed alldata
num_kids_wi = size(i_dist_wi,1);
same_kid_wi  = eye(num_kids_wi);

XXTD_mask_wi = (~same_kid_wi).*1; XXTD_mask_wi(same_kid_wi==1) = nan; XXTD_mask_wi(:,num_td_wi+(1:num_as_wi)) = nan;
XXAS_mask_wi = (~same_kid_wi).*1; XXAS_mask_wi(same_kid_wi==1) = nan; XXAS_mask_wi(:,1:num_td_wi)  = nan;
TDXX_mask_wi = (~same_kid_wi).*1; TDXX_mask_wi(same_kid_wi==1) = nan; TDXX_mask_wi(num_td_wi+(1:num_as_wi),:) = nan;
ASXX_mask_wi = (~same_kid_wi).*1; ASXX_mask_wi(same_kid_wi==1) = nan; ASXX_mask_wi(1:num_td_wi,:)  = nan;


TDTD_mask_wi = XXTD_mask_wi.*TDXX_mask_wi;
ASTD_mask_wi = XXAS_mask_wi.*TDXX_mask_wi;
TDAS_mask_wi = XXTD_mask_wi.*ASXX_mask_wi;
ASAS_mask_wi = XXAS_mask_wi.*ASXX_mask_wi;

%% Make figure of average distance wrt TD and wrt AS

avg_dist_win_td = squeeze(nanmean(nanmean(dist_win.*XXTD_mask_wi,2),4));
avg_dist_win_td=nanmean(avg_dist_win_td(1:num_td_wi,:),1);


avg_dist_win_as = squeeze(nanmean(nanmean(dist_win.*XXAS_mask_wi,2),4));

avg_dist_win_as=nanmean(avg_dist_win_as(num_td_wi+(1:num_as_wi),:),1);


permutation_n=100;
observeddifference=avg_dist_win_td-avg_dist_win_as ;

allobservations = [avg_dist_win_td , avg_dist_win_as];


randomdifferences = avg_dist_win_permut_g1-avg_dist_win_permut_g2;


for w=1:size(avg_dist_win_as,2)
    p(w)= length(find(abs(randomdifferences(w,:)) > abs(observeddifference(w)))+1) / (permutation_n+1);
    psmall(w) = (length(find(randomdifferences(w,:) < (w)))+1) / (permutation_n+1);

end


save('p_values_sliding_window','p','psmall')

figure('color','w','units','centimeters','position',[1.6228 32.6672 16.9333 13.1939]),

avg_dist_win_td = squeeze(nanmean(nanmean(dist_win.*XXTD_mask_wi,2),4));
avg_dist_win_as = squeeze(nanmean(nanmean(dist_win.*XXAS_mask_wi,2),4));


Age_window=mean(average_age_per_window,2)';

ind=find(p>0.05);
AVG_D_TD=avg_dist_win_td(1:num_td_wi,:);
AVG_D_ASD=avg_dist_win_as(num_td_wi+(1:num_as_wi),:);

BootStrCIDotPlot_2(Age_window(:,ind),AVG_D_TD(:,ind),'none',[0 0 1],0.05);
BootStrCIDotPlot_2(Age_window(:,ind),AVG_D_ASD(:,ind),'none',[1 0 0],0.05);hold on

ind=find(p<0.05);
BootStrCIDotPlot_2(Age_window(:,ind),AVG_D_TD(:,ind),[0 0 1],[0 0 1],0.05);
BootStrCIDotPlot_2(Age_window(:,ind),AVG_D_ASD(:,ind),[1 0 0],[1 0 0],0.05);hold on


box off
xlabel('Average age within window (years)')
ylabel(['Average pairwise distance to members' newline 'of own group (pixels)'])

set(gca, 'ylim', [235, 350],'YTick',[240 :20:340])%'YTicklabel',{'TD','ASD'})
set(gca, 'xlim', [1.8, 4.6],'XTick',[2 :.5:4.5])%'YTicklabel',{'TD','ASD'})


% set(gca, 'xlim', [4 size(NORM,3)+1],'XTick',[5:5:size(NORM,3)])
set(findall(gcf,'-property','FontSize'),'FontSize',14)
set(findall(gcf,'-property','FontName'),'FontName','Helvetica Neue')
set(findall(gcf,'-property','FontWeight'),'FontWeight','bold')
set(findall(gcf,'-property','box'),'box', 'off')


set(gcf, 'color', 'none');
set(gca, 'color', 'none');

figname=strcat('Fig_8C_Dispersion_sliding_windows','.pdf');

exportgraphics(gca,figname,'BackgroundColor','none');
