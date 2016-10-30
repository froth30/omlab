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

set(figure(10), 'Name','Question 1')

velTarR = [5 10 20 40];
velTarL = -velTarR;

tBoundsR = {[ 54.5   57.5  ], ...
            [  7.4    8.6  ], ...
            [ 24.8   25.4  ], ...
            [ 10.47  10.64 ]};
tBoundsL = {[ 34.2   35.6  ], ...
            [ 11.4   12.8  ], ...
            [ 27.3   27.8  ], ...
            [ 12.18  12.37 ]};

VT = velTarR;
GR = zeros(1,4);
GL = zeros(1,4);

for trial = 1:4
  load(sprintf('mat files\\BME101316_%i.mat', trial))
  posEye = lh;  % use left eye only
  
  velEyeR = findVel(posEye, t, tBoundsR{trial});
  velEyeL = findVel(posEye, t, tBoundsL{trial});
  
  gr = velEyeR / velTarR(trial);
  gl = velEyeL / velTarL(trial);
  
  GR(trial) = mean(gr);
  GL(trial) = mean(gl);
end

co = get(groot, 'DefaultAxesColorOrder');
coL = co(5,:);    coR = co(1,:);

plot(VT, GL, '*-', 'Color',coL, 'LineWidth',2);  hold on
plot(VT, GR, '*-', 'Color',coR, 'LineWidth',2)
xlim([0 50]);  ylim([0 1.2]);  grid on;  hold off

title('Smooth Pursuit Gain vs. Target Velocity')
xlabel('Target Velocity (\circ/sec)', 'FontWeight','bold')
ylabel('Smooth Pursuit Gain', 'FontWeight','bold')
legend('pursuit to the left', 'pursuit to the right', ...
       'Location','southeast')
