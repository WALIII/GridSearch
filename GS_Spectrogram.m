function GS_Spectrogram(data_samp,fs);

% Make a spectrogram with default params
% WAL3

% prerec: FinchScope repo


% make a spectrogram:
figure(); % make spectrogram..
ax1 = subplot(2,1,1);
ovlp = 3000;
N = 4000;
[b,a]=ellip(5,.2,80,[100]/(fs/2),'high'); % filter
[IMAGE,F,T] = fb_pretty_sonogram(filtfilt(b,a,data_samp./abs(max(data_samp))),fs,'low',0.0000001,'zeropad',0,'high',100);
colormap(hot)
imagesc(T,F,log(abs(IMAGE)+1e+2));set(gca,'YDir','normal');
ylabel('Hz')
xlabel('time (s)');
title('Spectrogram Unfiltered');

ax2 = subplot(2,1,2);
[IMAGE,F,T] = fb_pretty_sonogram(data_samp,fs,'low',0.0000001,'zeropad',0,'high',100);

imagesc(T,F,log(abs(IMAGE)+1e+2));set(gca,'YDir','normal');
ylabel('Hz')
xlabel('time (s)');
title('Spectrogram Unfiltered');
