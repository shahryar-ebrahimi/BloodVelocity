
clc
clear
close

%% BSP - CA1
%% Part 3
%% Author : Shahryar Ebrahimi
%% S.N.   : 810196093
%% loading...

signal    = load('EX1_plug_flow.mat'); signal = signal.data;

fs        = 100e6;                                            % sampling freq.
tprf      = 200e-6;                                           % The time between the measurements
c         = 1540;                                             % speed of sound (m/s)

%% Modifying...

for i = 1:size(signal, 2)-1
    R(i, :) = xcorr(signal(:, i), signal(:, i+1));
end
    
R_avg     = sum(R)/size(R, 1);              

%% Time Delay

Lag       = -(length(R_avg)-1)/2:(length(R_avg)-1)/2;
[~, I]    = max(abs(R_avg));                                  % index of maximum number in corr

lagDiff   = Lag(I);                                           % sample lag
ts        = abs(lagDiff/fs);                                  % time delay (s)

%% blood velocity

Blood_v   = (c*ts)/(2*tprf);                                  % speed of blood (m/s)

disp(['Blood Speed = ', num2str(abs(Blood_v)), ' m/s']);      % displaying blood velocity        

%% THE END %%
