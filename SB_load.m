% Get Ephys data

% Load data

load('00000_20211124_extract_logger_data_parameters_24-Nov-2021.mat','FS')
load('00000_20211124_CSC4.mat','AD_count_int16','AD_count_to_uV_factor');

Ch_data = double(AD_count_int16*AD_count_to_uV_factor); % convert the raw data to voltage
Fs = FS;                % Sampling frequency   
% T = 1/Fs;               % Sampling period
% fRange = 58:0.1:62;    % Range around 60Hz to look at
% WinSize = Fs*10;         % size of window to calc. the power in 
% j = 1; 
% for i = 1:WinSize:WinSize*100
% Ch_data_window = Ch_data(i:i+WinSize); 
% l = length(Ch_data_window);    % Length of all signal 
% t = (0:l-1)*T;          % Time vector
% [pxx,f] = pmtm(Ch_data_window,2,fRange,Fs);
% power60(j,:) = pxx;
% j = j+1; 
% end 