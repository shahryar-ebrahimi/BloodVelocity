
clc
clear
close

%% BSP - CA1
%% Part 1
%% Author : Shahryar Ebrahimi
%% S.N.   : 810196093
%% Calculating the cross-correlation function between two signals

fs          = 500;                    % sampling freq.
f           = 1;                      % signal freq.
t           = 0:1/fs:2-1/fs;          % signal length

sig1        = 10*sin(2*pi*f*t);       % 1st signal
sig2        = 5*cos(2*pi*f*t);        % 2nd signal


[R, Lag]    = xcorr(sig1, sig2);      % correlation of 2 signals
[~, I]      = max(abs(R));            % index of maximum number in corr

lagDiff     = Lag(I);                 % sample lag
timeDelay   = lagDiff/fs;             % time delay (s)

tR          = -(2-1/fs):1/fs:2-1/fs;  % cross-correlation x-axis

% Plotting...

subplot(3,1,1); plot(t, sig1); title('1st signal sin(2\pix)');           xlabel('Time (s)');     ylabel('Amplitude');
subplot(3,1,2); plot(t, sig2); title('2nd signal cos(2\pix)');           xlabel('Time (s)');     ylabel('Amplitude');
subplot(3,1,3); plot(tR, R);   title('Cross-Correlation of above signals');    xlabel('Time-lag (s)'); ylabel('Amplitude');
a        = gca;
a.XTick  = sort([-2:0.5:2  timeDelay]);

%%  Finding the delay between two signals

fs       = 100e6;                           % sampling freq. = 6 MHZ
f        = 5e6;                             % signal freq.
t        = 0:1/fs:(0.4e-6)-1/fs;            % sinusoid signal length

smpln    = 2000;                            % number of noise samples (20 microsecond * fs)
noise    = randn(1, smpln);                 % generating random normal noise

n        = (0.4e-6)*fs;                     % number of zeros to be padded for 0.4s of delay

sig1     = conv(sin(2*pi*f*t), noise);      % 1st signal by convolving sinusoid and noise
sig2     = padarray(sig1, [0 n], 'pre');    % 2nd signal by adding zeros in the first part of 1st signal

[R, Lag] = xcorr(sig1, sig2);               % correlation of 2 signals
[~, I]   = max(abs(R));                     % index of maximum number in corr

lagDiff   = Lag(I);                         % sample lag
timeDelay = lagDiff/fs;                     % time delay (s)

% Plotting...

t1       = 0:1/fs:length(sig1)/fs-1/fs;
t2       = 0:1/fs:length(sig2)/fs-1/fs;
tR       = -(length(sig2)/fs-1/fs):1/fs:length(sig2)/fs-1/fs;

figure, 
subplot(3,1,1); plot(t1, sig1); title('1st signal');                           xlabel('Time (s)');     ylabel('Amplitude');
subplot(3,1,2); plot(t2, sig2); title('2nd signal');                           xlabel('Time (s)');     ylabel('Amplitude');
subplot(3,1,3); plot(tR, R);    title('Cross-Correlation of above signals');   xlabel('Time-lag (s)'); ylabel('Amplitude');
a        = gca;
a.XTick  = sort([-30e-6:0.5e-5:-1e-6   5e-6:0.5e-5:30e-6  timeDelay]);

disp(['Time Delay = ', num2str(abs(timeDelay)), ' second(s)']);              % displaying time delay          

%% THE END %%

