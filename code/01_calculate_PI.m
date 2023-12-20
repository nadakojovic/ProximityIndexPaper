
clear all;
close all;
addpath(genpath('./func'))
% Proximity values

load('proximity_example_data.mat')


parpool('local',16)



% Parallel processing over subjects in the referent group
parfor k = 1:size(asd_allgaze, 3)
    fprintf('Subject %d\n', k);  % Displaying current subject number

    % Compute Proximity Index for the current subject
    % 'td_allgaze' is the referent gaze data, 'asd_allgaze' is the comparison gaze data
    % The function computes the PI for each frame of the current subject
    pi_per_frame_normalized = proximity_index(td_allgaze, asd_allgaze, size(asd_allgaze, 2), k);

    % Storing the computed PI in a structure array for each subject
    % This allows for individual analysis of each subject later
    pi_asd_allsubjects(k,:) = pi_per_frame_normalized;


end
mean_pi=nanmean(pi_asd_allsubjects,2);
save pi_asd
