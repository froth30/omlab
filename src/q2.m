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

set(figure(20), 'Name','Question 2')

tboundsL = {[ 49.69  50.16 ], ...
            [  4.8    5.33 ], ...
            [  6.97   7.1  ], ...
            [  2.44   2.54 ]};
tboundsR = {[ 39.29  40.56 ], ...
            [ 29.65  30.5  ], ...
            [  5.89   6.13 ], ...
            [  1.98   2.09 ]};

f = [0.05 0.1 0.5 1];
GL = zeros(1,4);
GR = zeros(1,4);

trial = 5:8;
for i = 1:4
  load(sprintf('mat files\\BME101316_%i.mat', trial(i)))
  posEye = lh;  % use left eye only
  
  tbl = tboundsL{i};  % time bounds (pursuit to left)
  tbr = tboundsR{i};  % time bounds (pursuit to right)
  
  velTarL = findVel(st, t, tbl, 'Mean',true);
  velTarR = findVel(st, t, tbr, 'Mean',true);
  
  velEyeL = findVel(posEye, t, tbl);
  velEyeR = findVel(posEye, t, tbr);
  
  gr = velEyeR ./ velTarR;
  gl = velEyeL ./ velTarL;
  
  GR(i) = mean(gr);
  GL(i) = mean(gl);
end

co = get(groot, 'DefaultAxesColorOrder');
coL = co(5,:);    coR = co(1,:);

plot(f, GL, '*-', 'Color',coL, 'LineWidth',2);  hold on
plot(f, GR, '*-', 'Color',coR, 'LineWidth',2)
xlim([0 1]);  ylim([0 1.2]);  grid on;  hold off

title('Smooth Pursuit Gain vs. Target Frequency')
xlabel('Target Frequency (Hz)', 'FontWeight','bold')
ylabel('Smooth Pursuit Gain', 'FontWeight','bold')
legend('pursuit to the left', 'pursuit to the right', ...
       'Location','southeast')
