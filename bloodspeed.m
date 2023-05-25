
function v = bloodspeed(sig1, sig2, tprf, c, fs)
%
% a function to find the bloodspeed using 2 measurments
% BSP - CA1
% Author : Shahryar Ebrahimi
% S.N.   : 810196093
%
%
ts  = delayfinder(sig1, sig2, fs);             % finding the delay between 2 signals
v   = (c*ts)/(2*tprf);                         % speed of blood (m/s)

end

% -------------------------------------------------------------------------

function timeDelay = delayfinder(sig1, sig2, fs)
%
% a function to find the delay between 2 signals.
% BSP - CA1
% Author : Shahryar Ebrahimi
% S.N.   : 810196093
%
%
[R, Lag] = xcorr(sig1, sig2);               % correlation of 2 signals
[~, I]   = max(abs(R));                     % index of maximum number in corr

lagDiff   = Lag(I);                         % sample lag
timeDelay = lagDiff/fs;                     % time delay (s)

end