%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%
function xx = smoothData(x, varargin)
  
  switch nargin
    case 1
      n = 10;
    case 2
      n = varargin{1};
    otherwise
      error('Function ''smoothData'' accepts no more than 2 arguments.')
  end
  
  windowSize = round(length(x)/n);
  b = ones(1,windowSize) / windowSize;
  a = 1;
  
  xx = filter(b,a,x);
  
end
