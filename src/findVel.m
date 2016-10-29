%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%
function v = findVel(x, t, tbounds)
  
  % Find bound indices
  i1 = find(t > tbounds(1), 1);
  i2 = find(t < tbounds(2), 1, 'last');
  
  % Compute time step
  dt = t(2) - t(1);
  
  % Compute differnce
  v = (x(i1+1:i2) - x(i1:i2-1)) / dt;
%   v = smoothData(v, 2);
  
end
