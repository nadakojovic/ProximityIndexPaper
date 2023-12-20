
clear all
close all

addpath(genpath('./code'))

%%


load('asdet.mat')
% Initialize an empty structure with consistent fields
saccades_data = struct('participant', {}, 'total_saccade_number', {}, 'total_length', {}, 'mean_length', {}, 'median_length', {});
fixations_data = struct('participant', {}, 'total_fixation_number', {}, 'total_length', {}, 'mean_length', {}, 'median_length', {}, 'focal_perc', {}, 'ambiental_perc', {});


% Iterate through each Tobii file for processing
for s = 1:size(et_asd,2)


    % Process saccade data
    [total_saccade_number, total_saccade_length,...
        mean_saccade_length, median_saccade_length] = process_saccades(et_asd(s).recording.SaccadeIndex, et_asd(s).recording.GazeEventDuration);

    % Store saccade data in the saccades_data structure
    saccades_data(s) = struct('participant', filename, 'total_saccade_number', total_saccade_number,...
        'total_length', total_saccade_length, 'mean_length', mean_saccade_length,...
        'median_length', median_saccade_length);

    % Process fixation data
    [total_fixation_number, total_fixation_length,...
        mean_fixation_length, median_fixation_length, focal_perc, ambiental_perc] = process_fixations(et_asd(s).recording.FixationIndex, et_asd(s).recording.GazeEventDuration, et_asd(s).recording.SaccadicAmplitude);

    % Store fixation data in the fixations_data structure
    fixations_data(s) = struct('participant', filename, 'total_fixation_number', total_fixation_number, 'total_length', total_fixation_length, 'mean_length', mean_fixation_length, 'median_length', median_fixation_length, 'focal_perc', focal_perc, 'ambiental_perc', ambiental_perc);
end

% Save the processed data
save('asd_fixations_saccades.mat', 'fixations_data', 'saccades_data');

load('tdet.mat')
% Iterate through each Tobii file for processing
for s = 1:size(et_td,2)


    % Process saccade data
    [total_saccade_number, total_saccade_length,...
        mean_saccade_length, median_saccade_length] = process_saccades(et_td(s).recording.SaccadeIndex, et_td(s).recording.GazeEventDuration);

    % Store saccade data in the saccades_data structure
    saccades_data(s) = struct('participant', filename, 'total_saccade_number', total_saccade_number,...
        'total_length', total_saccade_length, 'mean_length', mean_saccade_length,...
        'median_length', median_saccade_length);

    % Process fixation data
    [total_fixation_number, total_fixation_length,...
        mean_fixation_length, median_fixation_length, focal_perc, ambiental_perc] = process_fixations(et_td(s).recording.FixationIndex, et_td(s).recording.GazeEventDuration, et_td(s).recording.SaccadicAmplitude);

    % Store fixation data in the fixations_data structure
    fixations_data(s) = struct('participant', filename, 'total_fixation_number', total_fixation_number, 'total_length', total_fixation_length, 'mean_length', mean_fixation_length, 'median_length', median_fixation_length, 'focal_perc', focal_perc, 'ambiental_perc', ambiental_perc);
end
% Save the processed data
save('td_fixations_saccades.mat', 'fixations_data', 'saccades_data');
