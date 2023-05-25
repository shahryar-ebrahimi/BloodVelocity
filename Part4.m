
clc
clear
close

%% BSP - CA1
%% Part 4
%% Author : Shahryar Ebrahimi
%% S.N.   : 810196093
%% loading...

signal    = load('EX1_plug_flow.mat'); signal = signal.data;

fs        = 100e6;                                            % sampling freq.
tprf      = 200e-6;                                           % The time between the measurements
c         = 1540;                                             % speed of sound (m/s)

%% Deviding & Modifying...

for j = 0:floor((size(signal, 1))/200)-1
    
    sig_tmp = signal(200*j+1:200*(j+1), :);
    
    for i = 1:size(sig_tmp, 2)-1
        R(i, :) = xcorr(sig_tmp(:, i), sig_tmp(:, i+1));
    end
    
    R_avg(j+1, :)    = sum(R)/size(R, 1);              

end

%% Blood Speed

for i = 1:size(R_avg, 1)
    
    Rtmp       = R_avg(i, :);
    
    % Time Delay

    Lag        = -(length(Rtmp)-1)/2:(length(Rtmp)-1)/2;
    [~, I]     = max(abs(Rtmp));                                   % index of maximum number in corr

    lagDiff    = Lag(I);                                           % sample lag
    ts         = abs(lagDiff/fs);                                  % time delay (s)

    % blood velocity

    Blood_v(i) = (c*ts)/(2*tprf);                                  % speed of blood (m/s)
    
    if i == 1
        str = [num2str(i) 'st'];
    elseif i == 2
        str = [num2str(i) 'nd'];
    elseif i == 3
        str = [num2str(i) 'rd'];
    else
        str = [num2str(i) 'th'];
    end
    
    if i == 10
        disp([['Blood Speed in ' str ' 2 microsecond  = '], num2str(abs(Blood_v(i))), ' m/s']);      % displaying blood velocity        
    else
        disp([['Blood Speed in ' str '  2 microsecond  = '], num2str(abs(Blood_v(i))), ' m/s']);      % displaying blood velocity        
    end
    
end

clear R_avg R Rtmp sig_tmp str ts lagDiff Lag j I i 

%% THE END %%
