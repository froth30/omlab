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

set(gcf, 'Name','Question 1')
axlh = subplot(1,2,1);  cla;  hold on
axrh = subplot(1,2,2);  cla;  hold on

tBoundsL = {[60.32 65.66], ...
  [18.8  21.34], ...
  [22.01 23.26], ...
  [22.23 22.97]};
tBoundsR = {[53.32 58.88], ...
  [14.8  17.46], ...
  [19.42 20.73], ...
  [20.75 21.34]};

for trial = 1:4
  load(sprintf('mat files\\BME101316_%i.mat', trial))
  
  velTarL = findVel(st, t, tBoundsL{trial});
  velEyeL = findVel(lh, t, tBoundsL{trial});
  GL = smoothData(velEyeL ./ velTarL);
  
  velTarR = findVel(st, t, tBoundsR{trial});
  velEyeR = findVel(rh, t, tBoundsR{trial});
  GR = smoothData(velEyeR ./ velTarR);
  
  tnL = linspace(0,1,length(GL));
  tnR = linspace(0,1,length(GR));
  
  plot(axlh, tnL, GL)
  plot(axrh, tnR, GR)
end

side = {'Left', 'Right'};
ax = [axlh axrh];
for i = 1:2
  subplot(ax(i));  grid on;  hold off
  title(sprintf('Smooth Pursuit Gain (%s Eye)', side{i}))
  ylim([0 10])
  xlabel('Time (s)', 'FontWeight','bold')
  ylabel('Gain (arb. units)', 'FontWeight','bold')
  legend('5\circ/s', '10\circ/s', '20\circ/s', '40\circ/s')
end
