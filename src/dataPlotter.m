%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%
function dataPlotter(varargin)
  persistent filename lh rh st t
  repeat = false;
  
  % Load trial
  switch nargin
    case 0
      loadTrial();  repeat = true;
    case 1
      loadTrial(varargin{1})
    otherwise
      error('[!] Too many input arguments.')
  end
  
  % Prepare figure
  figure(1);  clf;  set(gcf, 'Name',filename)
  co = get(groot, 'DefaultAxesColorOrder');
  
  % Plot trial data
  plot(t, st, 'r');  hold on
  plot(t, lh, 'Color',co(5,:))
  plot(t, rh, 'Color',co(1,:))
  ylim([-30 +30]);  grid on;  hold off
  
  % Annotate plot
  title('Eye Movement')
  xlabel('Time (s)',             'FontWeight','bold')
  ylabel('Eye Position (\circ)', 'FontWeight','bold')
  legend('Target', 'Left Eye', 'Right Eye')
  
  if repeat
    dataPlotter()
  end
  
end
