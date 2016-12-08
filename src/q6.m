%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%


%% Plot second VOR test: stationary target

clear;  loadTrial(23)
dataPlotter(23);  hold on
set(gcf, 'Name','Question 6')
title('VOR Test 2: \itStationary Target (visual)')


%% Plot third VOR test: moving target

clear;  loadTrial(24)
dataPlotter(24);  hold on
set(gcf, 'Name','Question 6')
title('VOR Test 3: \itMoving Target (visual)')


%% Plot fifth VOR test: stationary target "in the dark"

clear;  loadTrial(26)
dataPlotter(26);  hold on
set(gcf, 'Name','Question 6')
title('VOR Test 5: \itStationary Target (non-visual)')


%% Plot fifth VOR test: moving target "in the dark"

clear;  loadTrial(27)
dataPlotter(27);  hold on
set(gcf, 'Name','Question 6')
title('VOR Test 6: \itMoving Target (non-visual)')


%% Compute gain
% Run this section after running any one of the previous sections

series = {'velChr', 'velEye'};

for i = 1 : length(series)
  fprintf('Select data points for computing: %s\n', series{i})
  count = 0;
  done = false;
  while ~done
    try
      % Select two points
      [x1,y1] = selectDataPoint();
      [x2,y2] = selectDataPoint();
      count = count + 1;
      % Compute slope (velocity)
      eval(sprintf('%s(count) = %d', ...
        series{i}, (y2-y1)/(x2-x1)))
    catch  % remove data cursor before hitting enter to invoke an error
      done = true;
    end
  end
end

% Compute average gain
gains = velEye ./ velChr;
G = mean(gains);
