%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%


%% Annotate first intersaccadic interval (ISI)

clear
dataPlotter(21);  hold on
set(gcf, 'Name','Question 5')
title('Saccadic Tests: \itTaking a Closer Look')
xlim([3.4 5]);  ylim([-15 20])

% Annotate target
plot([4 5], [0 0], 'r:')
annotation('doublearrow', [0.4223 0.5667], [0.32 0.32],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
annotation('textbox', [0.488 0.293 0.022 0.0485],...
           'String','T',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle',...
           'FontWeight','bold',...
           'FitBoxToText','off',...
           'EdgeColor','none',...
           'BackgroundColor',[1 1 1]);

% Annotate right eye...
co = get(groot, 'DefaultAxesColorOrder');  coR = co(1,:);
plot([3.4 5], -2.261*[1 1], ':', 'Color',coR)
plot([4.485 5], 7.89*[1 1], ':', 'Color',coR)

% ... Annotate ISI
annotation('doublearrow', [0.5190 0.63], [0.385 0.385],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
annotation('textbox', [0.572 0.368 0.03 0.0343],...
           'String','ISI',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle',...
           'FontWeight','bold',...
           'FitBoxToText','off',...
           'EdgeColor','none',...
           'BackgroundColor',[1 1 1])

% ... Annotate t2
annotation('doublearrow', [0.5683 0.63], [0.423 0.423],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
text      (4.371, -0.75, 't2',...
           'FontWeight','bold',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle')

% ... Annotate a1
annotation('doublearrow', [0.3 0.3], [0.405 0.533],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
annotation('textbox', [0.29 0.465 0.0209 0.03],...
           'String','a1',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle',...
           'FontWeight','bold',...
           'FitBoxToText','off',...
           'EdgeColor','none',...
           'BackgroundColor',[1 1 1])

% ... Annotate a2
annotation('doublearrow', [0.8 0.8], [0.405 0.644],...
           'Head1Width',8, 'Head1Length',8,...
           'Head2Width',8, 'Head2Length',8)
annotation('textbox', [0.79 0.5 0.0209 0.03],...
           'String','a2',...
           'HorizontalAlignment','center',...
           'VerticalAlignment','middle',...
           'FontWeight','bold',...
           'FitBoxToText','off',...
           'EdgeColor','none',...
           'BackgroundColor',[1 1 1])


%% Find target 'saccades'

clear;  loadTrial(21)

tframes = 0:3:t(end-1);
nframes = length(tframes);

dataPlotter(21);  ylim([-15 20])

for i = 1:nframes
  fprintf('\nFrame #%i\n', i)
  title(['Saccadic Tests: \itFrame by Frame ('...
                 num2str(i) '/' num2str(nframes) ')'])
  tframe = tframes(i);  xlim([0 3] + tframe)
  dt = t(2)-t(1);  ind = tframe/dt+1 : (tframe+3)/dt;
  
  % Find target delay
  trise = t(find(st(ind) >  1, 1));
  if isempty(trise); continue; end
  tfall = t(find(st(ind) < -1, 1));
  if isempty(tfall); continue; end
  T0 = min(trise,tfall);
  T1 = max(trise,tfall);
  T  = T1 - T0;
  
  % Measure amplitudes
  disp('                           ----O    O----')
  disp('  Measure amplitudes...        |    |    ')
  disp('                               +----+    ')
  [~,a1] = selectDataPoint();
  fprintf('%+30s', sprintf('a1 = %f        ', a1))
  [~,a2] = selectDataPoint();
  fprintf('a2 = %f\n\n', a2)
  
  % Measure latency of second saccade and intersaccadic interval (ISI)
  disp('                           ----+    +----')
  disp('  Measure ISI bounds...        |    |    ')
  disp('                               O----O    ')
  [ISI0,~] = selectDataPoint();
  fprintf('%+30s', sprintf('ISI0 = %f        ', a1))
  [ISI1,~] = selectDataPoint();
  fprintf('ISI1 = %f\n', a2)
  t2   = ISI1 - T1;    fprintf('    ->  t2  = %f\n',  t2)
  ISI  = ISI1 - ISI0;  fprintf('    ->  ISI = %f\n', ISI)
  
  % Save measurements in struct
  fprintf('\n  Saving frame...\n\n')
  tbl.T(i) = T;    tbl.a1(i) = a1;    tbl.a2 (i) = a2;
                   tbl.t2(i) = t2;    tbl.ISI(i) = ISI;
end
disp('End of Saccadic Tests! Press any button to exit...')
waitforbuttonpress;  close


%% Compute means for each of the 11 different target delays

i = find(tbl.T);    % find all frames with nonzero values of T
T = tbl.T(i);    a1 = tbl.a1(i);    a2  = tbl.a2 (i);
                 t2 = tbl.t2(i);    ISI = tbl.ISI(i);

Texp = [0.02 0.05:0.05:0.50];
params = {'a1', 'a2', 't2', 'ISI'};
for i = 1:11
  Tind = find(abs(T-Texp(i)) < 0.0001);
  for n = 1:4
    p = params{n};
    eval(sprintf('%s_(i) = mean(%s(Tind));', p,p))
  end
end

tbl_.T = Texp;    tbl_.a1 = a1_;    tbl_.a2  = a2_ ;
                  tbl_.t2 = t2_;    tbl_.ISI = ISI_;

                  
%% Part (a)  Plot mean values for a1 and a2 vs. T

figure(50)

plot(tbl_.T, [tbl_.a1; tbl_.a2], 'LineWidth',1.5)
grid on

title('Mean Values for {\ita1} and {\ita2} vs. {\itT}')
xlabel('Target Delay (s)', 'FontWeight','bold')
ylabel('Position (\circ)',   'FontWeight','bold')
legend('a1', 'a2')

                  
%% Part (b)  Plot mean values for t2 and ISI vs. T

figure(51)

plot(tbl_.T, [tbl_.t2; tbl_.ISI], 'LineWidth',1.5)
grid on

title('Mean Values for {\itt2} and {\itISI} vs. {\itT}')
xlabel('Target Delay (s)', 'FontWeight','bold')
ylabel('Position (\circ)',   'FontWeight','bold')
legend('t2', 'ISI')

