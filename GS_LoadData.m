
% Load all data into the same 

% Get all folders in directory
files2 = dir(pwd);
files2(ismember( {files2.name}, {'.', '..','00000_20211124_extract_logger_data_parameters_24-Nov-2021.mat'})) = [];  %remove . and .. and Processed

% Get a logical vector that tells which is a directory.
dirFlags2 = [files2.isdir];
% Extract only those that are directories.
subFolders2 = files2(dirFlags2);
% Print folder names to command window.

% load conversions 
load('00000_20211124_extract_logger_data_parameters_24-Nov-2021.mat','FS')
clear data_samp_tot data_samp
for k = 1 : length(files2)
    load(files2(k).name);
    Ch_data = double(AD_count_int16*AD_count_to_uV_factor); % convert the raw data to voltage
    data_samp_tot(:,k) = Ch_data(:,1:20000000);
    clear Ch_data
end