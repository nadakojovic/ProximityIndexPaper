function [total_saccade_number, total_saccade_length, mean_saccade_length, median_saccade_length] = process_saccades(saccade_index, event_duration)
    total_saccade_order = unique(saccade_index(~isnan(saccade_index)));
    total_saccade_number = length(total_saccade_order);
    
    sacc_duration = zeros(size(total_saccade_order));
    
    for k = 1:total_saccade_number
        index_saccade = find(saccade_index == total_saccade_order(k));
        start_s = index_saccade(1);
        if start_s > 1
            sacc_duration(k) = event_duration(start_s - 1);
        else 
            sacc_duration(k) = event_duration(start_s);
        end
    end

    total_saccade_length = nansum(sacc_duration) / 1000;
    mean_saccade_length = mean(sacc_duration) / 1000;
    median_saccade_length = median(sacc_duration) / 1000;
end
