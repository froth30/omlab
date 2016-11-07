%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%
function [x,y] = selectDataPoint()
  
  % Register data cursor manager
  dcm = datacursormode(gcf);  datacursormode on
  
  % Wait for keypress
  k = 0;
  while ~k
    k = waitforbuttonpress;
  end
  
  % Acquire cursor position
  pos = getCursorInfo(dcm).Position;
  x = pos(1);
  y = pos(2);
  
end
