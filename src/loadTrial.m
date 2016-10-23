%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%

clear;  dir_  = 'mat files';  file_ = 'BME101316';

trial_str = input('Trial to plot: ', 's');
trial = str2double(trial_str);

if ~isnan(trial)
  if trial < 1 || trial > 28
    disp('[!] Couldn''t load file. Trial range is 1-28.')
    dataPlotter()
  end
  if trial >= 22
    file_([7 9]) = '5';
  end
elseif strcmp(trial_str(1:3), 'vor')
  trial = str2double(trial_str(4:end));
  if isnan(trial)
    disp('[!] Invalid input. (Ctrl+C -> exit)')
    dataPlotter()
  elseif trial < 22 || trial > 27
    disp('[!] Couldn''t load file. Trial range is 22-27.')
    dataPlotter()
  else
    disp('[.] Plotting our VOR data...')
    file_ = fullfile('VOR without chair channel)', file_);
  end
else
  disp('[!] Invalid input. (Ctrl+C -> exit)')
  dataPlotter()
end

file_ = sprintf('%s_%i.mat', file_, trial);
load(fullfile(dir_, file_))

set(gcf, 'Name',file_)
