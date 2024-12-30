%% Hilbert Transform and Clustering Demo
% This script demonstrates the use of the Hilbert Transform for vibration signal analysis
% and clustering of data peaks to detect defects in railway wheelsets.
% 
% Author: [Jakub Dziedzic/UpdatePlus]
% Date: [12.11.2022]
% License: MIT

%% Parameters
% Adjustable parameters for the algorithm. Modify these as needed.
window_length = 3; % Length of the analysis window in seconds (default: 3 seconds)
histogram_bin_width = 10; % Bin width for the histogram (default: 10)
clustering_range = 100; % Range for clustering in samples (default: 100)
percentile_threshold = 95; % Percentile for peak selection (default: 95)

%% Input Data
% 'a' should contain the acceleration data (1D array)
% Example input:
% a = [your_acceleration_data];

%% Initialization
len = length(a);  % Total length of the data packet
sub_len = floor(window_length / 3) * 1000;  % Sub-packet length
nSub = ceil(len / sub_len);  % Number of sub-packets
sm1 = mat2cell(a, diff(round(linspace(0, len, nSub + 1))), 1);  % Splitting into sub-packets

%% Hilbert Transform
% Applying the Hilbert Transform to each sub-packet
for i_sub = 1:nSub
    y{i_sub} = abs(hilbert(sm1{i_sub}));  % Hilbert Transform
end
% Extracting the percentile threshold and removing values below it
for i_sub = 1:nSub
    Qauntil(i_sub) = prctile(y{i_sub}, percentile_threshold);  % Percentile threshold
    idx = find(y{i_sub} <= Qauntil(i_sub));  % Indices below threshold
    y{i_sub}(idx) = NaN;  % Mark values below the threshold as NaN
end

%% Clustering
% Preparing data for clustering
hilb_data = zeros(len, 1);  % Combined data array
for i = 1:nSub
    if i ~= nSub
        hilb_data((i - 1) * length(y{i}) + 1:length(y{i}) * i, 1) = y{i};
    else
        hilb_data((i - 1) * length(y{i}) + 1:len, 1) = y{i};
    end
end
list_of_hilb_res = find(((isnan(hilb_data) - 1) .^ 2));  % List of non-NaN indices
list_of_hilb_res(:, 2) = 0;
hilb_data(isnan(hilb_data)) = 0;  % Replace NaNs with zeros

% Performing clustering
add = 0;
for ii = 1:len
    belong_list(:, 1) = list_of_hilb_res(:, 1) < list_of_hilb_res(ii, 1) + clustering_range / 2;
    belong_list(:, 2) = list_of_hilb_res(ii, 1) - clustering_range / 2 < list_of_hilb_res(:, 1);
    belong_list(:, 3) = belong_list(:, 1) .* belong_list(:, 2);
    local_list = find(belong_list(:, 3));
    test_list = list_of_hilb_res(local_list, 2);
    if sum(test_list) == 0
        add = add + 1;
        list_of_hilb_res(local_list, 2) = add;
    else
        list_of_hilb_res(local_list, 2) = add;
    end
end

% Clustering summary
l_clust = max(list_of_hilb_res(:, 2));
for ii = 1:l_clust
    temp_list = list_of_hilb_res(list_of_hilb_res(:, 2) == ii, 1);
    clust_summary(ii, 1) = min(temp_list);
    clust_summary(ii, 2) = max(temp_list);
    clust_summary(ii, 3) = clust_summary(ii, 2) - clust_summary(ii, 1);  % Cluster length
end

% Cleaning small clusters
clean_clust_summ = clust_summary(clust_summary(:, 3) > 10, :);  % Remove clusters smaller than 10 samples
[nc, ~] = size(clean_clust_summ);
for ii = 2:nc
    clean_clust_summ(ii, 4) = clean_clust_summ(ii, 2) - clean_clust_summ(ii - 1, 1);  % Distance between clusters
end

%% Histogram Analysis
% Creating histogram of inter-cluster distances
ha = histogram(clean_clust_summ(2:end, 4), 'BinWidth', histogram_bin_width);
try
    histo_data_capture = ha.Values(1:100);  % Capture first 100 bins
catch
    histo_data_capture = ha.Values;  % Or fewer bins if less data
end

%% Output
% The variable 'histo_data_capture' contains the histogram data to be saved or analyzed further.
