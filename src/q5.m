%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%

clear

set(gcf, 'Name','Question 5')

load('mat files\BME101316_21.mat')

%% Find target 'saccades'

spikeRises = [];
spikeFalls = [];
index = 1;

spikeRise = NaN;

while ~isempty(spikeRise)
  
  spikeRise = (index-1) + find(st(index:end) > 1, 1);
  spikeRises = [spikeRises spikeRise];
  
  spikeFall = (spikeRise-2) + find(st(spikeRise:end) < 1, 1);
  spikeFalls = [spikeFalls spikeFall];
  
  index = spikeFall + 1;
  
end

%% Compute target delays

starts = t(spikeRises);
delays = t(spikeFalls) - starts;

% Print results
disp([starts delays])
