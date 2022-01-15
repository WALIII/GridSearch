
function GS_main(data_samp, FS);
% get data into bite-size chunk
% data_samp_tot(:,4) = Ch_data(:,1:100000);
%data_samp = median(data_samp_tot(:,1:4)');
% data_samp = (data_samp_tot(:,4));
fs =  FS;

d = designfilt('bandpassiir','FilterOrder',2, ...
               'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
               'DesignMethod','butter','SampleRate',fs);
buttLoop = filtfilt(d,data_samp);
      
data_samp = buttLoop;
fs = FS;

% Plot power Spectrum
x = data_samp;
y = fft(x);
n = length(x);          % number of samples
f = (0:n-1)*(fs/n);     % frequency range
power = abs(y).^2/n;    % power of the DFT

figure();
plot(f,smooth(power,10))
xlim([20 150]);
xlabel('Frequency')
ylabel('Power')




% % Reasigned spectrogram:
% [Gconsensus,F,T] = CY_Get_Consensus(data_samp,fs);
% figure(); imagesc(flipdim(Gconsensus{1},1),[0 200]); colormap pink


% plot spectrogram around 60hz
ds_factor = 100;
data2use = (data_samp(1:ds_factor:end));
fs2 = fs/ds_factor;

% Parameters
frequencyLimits = [58 62]; % Hz
leakage = 0.85;
timeResolution = 100/fs2; % seconds
overlapPercent = 95;
reassignFlag = true;
%%
% Index into signal time region of interest
% Compute spectral estimate
% Run the function call below without output arguments to plot the results
figure();
[P,F,T] = pspectrum(data2use,fs2, ...
'spectrogram', ...
'FrequencyLimits',frequencyLimits, ...
'Leakage',leakage, ...
'TimeResolution',timeResolution, ...
'OverlapPercent',overlapPercent, ...
'Reassign',reassignFlag);
figure();
mesh(seconds(T),F,P)
xlabel('Time')
ylabel('Frequency')
axis tight
view(2)
colormap pink
%

figure();
subplot(3,1,1);
mesh(seconds(T),F,P)
xlabel('Time')
ylabel('Frequency')
axis tight
view(2)
colormap pink

subplot(3,1,2);
mesh(seconds(T),F,P)
xlabel('Time')
ylabel('Frequency')
axis tight
view(2)
colormap pink
%
[fridge,~,lridge] = tfridge(P,F,0.01,'NumRidges',1,'NumFrequencyBins',1);
hold on
plot3(seconds(T),fridge,P(lridge),'-','linewidth',3)
hold off

subplot(3,1,3);
plot(seconds(T),smooth(mean(fridge(:,:),2),10)); ylim(frequencyLimits);


figure(); 
plot(fridge); 
hold on; 
F2 = fridge;
F2(zscore(max(P))<2.5) = NaN;
plot(F2,'r.')


figure(); imagesc(T,F,log(abs(P)+1e+2));set(gca,'YDir','normal'); colormap(hot)

figure(); spectrogram(data_samp(1:100:end),128,120,1280,fs)
% 
% figure();
% [c,lags] = xcorr(fridge(:,1),fridge(:,2),'coeff');
% stem(lags,c)