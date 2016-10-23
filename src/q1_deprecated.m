%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%
function q1
  
  set(gcf, 'Name','Question 1')
  axlh = subplot(2,1,1);  hold on;  grid on
  axrh = subplot(2,1,2);  hold on;  grid on
  
  % Load appropriate trials
  for trial = 1:4
    load(sprintf('mat files\\BME101316_%i.mat', trial))
    
    vst = findVel(st, t);
    vlh = findVel(lh, t);
    vrh = findVel(rh, t);
    
    Glh = vlh ./ vst;
    Grh = vrh ./ vst;
    
    t = t(1:end-1);
    
    plot(axlh, t, Glh)
    plot(axrh, t, Grh)
    
  end
  
  side = {'Left', 'Right'};
  ax = [axlh axrh];
  for i = 1:2
    title(ax(i), sprintf('Smooth Pursuit Gain (%s Eye)', side{i}))
    ylim(ax(i), [-100 +100])
    xlabel(ax(i), 'Time (s)', 'FontWeight','bold')
    ylabel(ax(i), 'Gain (arb. units)', 'FontWeight','bold')
    legend(ax(i), '5\circ/s', '10\circ/s', '20\circ/s', '40\circ/s')
  end
  
end


function d = findVel(x, t)
  
  dt = t(2) - t(1);
  d = (x(2:end) - x(1:end-1)) / dt;
  
end
