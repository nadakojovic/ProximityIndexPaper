function [total_fixation_number, total_fixation_length, mean_fixation_length, median_fixation_length, focal_perc, ambiental_perc] = process_fixations(fixation_index, event_duration, sacc_ampl)
total_fixation_order = unique(fixation_index(~isnan(fixation_index)));
total_fixation_number = length(total_fixation_order);

fix_duration = zeros(size(total_fixation_order));
focal_fix = zeros(size(total_fixation_order));

for n = 1:total_fixation_number - 1
    start_f = find(fixation_index == total_fixation_order(n), 1, 'first');
    fix_duration(n) = event_duration(start_f);
 
     % Check if sacc_ampl is a cell and convert to a number if necessary
   % Check if sacc_ampl is a cell and convert to a number if necessary
    if iscell(sacc_ampl)
        if ischar(sacc_ampl{start_f})
            % Replace comma with period and convert string to a number
            sacc_ampl_current_str = strrep(sacc_ampl{start_f}, ',', '.');
            sacc_ampl_current = str2double(sacc_ampl_current_str);
        else
            % Use the numeric value directly if it's not a string
            sacc_ampl_current = sacc_ampl{start_f};
        end
    else
        sacc_ampl_current = sacc_ampl(start_f);
    end
  
    
    % Classify fixations based on duration and saccade amplitude
    if fix_duration(n) > 180 && sacc_ampl_current < 5
        focal_fix(n) = 1; % Focal fixation
    elseif fix_duration(n) < 180 && sacc_ampl_current > 5
        focal_fix(n) = 2; % Ambient fixation
    else
        focal_fix(n) = NaN; % Unclassified
    end
end

total_fixation_length = sum(fix_duration) / 1000;
mean_fixation_length = mean(fix_duration) / 1000;
median_fixation_length = median(fix_duration) / 1000;
focal_perc = (sum(focal_fix == 1) / total_fixation_number) * 100;
ambiental_perc = (sum(focal_fix == 2) / total_fixation_number) * 100;
end
