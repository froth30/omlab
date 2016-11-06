%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%
function loadTrial(varargin)
  
  % Initialize parts of filepath
  dir_ = 'mat files';  file_ = 'BME101316';
  
  % Check for invalid argument
  try
    switch nargin
      case 0
        trial = input('Trial to plot: ');
      case 1
        trial = varargin{1};
        if ~isnumeric(trial)
          error()
        end
      otherwise
        error()
    end
  catch
    disp('[!] Invalid input. (Ctrl+C -> exit)')
    loadTrial();  return  % try again
  end
  
  % Configure file path
  if trial >= 1 && trial <= 28
    if trial >= 22
      file_([7 9]) = '5';
    end
  elseif trial <= -22 && trial >= -27
    file_ = fullfile('VOR without chair channel)', file_);
    trial = -trial;
  else
    disp('[!] Couldn''t load file. Trial range is 1-28.')
    disp('     * Enter ''-'' 22-27 for erred VOR data...')
    loadTrial();  return  % try again
  end
  
  % Load data from file
  file_ = sprintf('%s_%i.mat', file_, trial);
  load(fullfile(dir_, file_))
  
  % Save data to base workspace (outlive function workspace)
  assignin( 'caller',  'filename',  file_ )
  assignin( 'caller',  'lh'      ,  lh    )
  assignin( 'caller',  'rh'      ,  rh    )
  assignin( 'caller',  'st'      ,  st    )
  assignin( 'caller',  't'       ,  t     )
  
end
