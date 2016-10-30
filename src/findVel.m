%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%
function v = findVel(x, t, tbounds, varargin)
  
  % Find bound indices
  i1 = find(t > tbounds(1), 1);
  i2 = find(t < tbounds(2), 1, 'last');
  
  % Compute numerical differences (within sample)
  xs = x(i1:i2);    dx = diff(xs);
  ts = t(i1:i2);    dt = diff(ts);
  
  % Compute velocity vector (within sample)
  v = dx ./ dt;
  
  % Smoothen data, if called for
  if ~isempty(varargin)
    property = varargin{1};
    value    = varargin{2};
    if strcmp(property,'Smoothing')
      if isnumeric(value)
        v = smoothData(v, value);
      elseif strcmp(value,'auto')
        v = smoothData(v, 2);
      end
    end
  end
  
end
