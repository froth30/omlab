%
%                    Case Western Reserve University
%
%                                EBME 318
%                   Biomedical Engieering Laboratory I
%                               Fall 2016
%
% Author: Ted Frohlich <ttf10@case.edu>
%

loadTrial()

co = get(groot, 'DefaultAxesColorOrder');

plot(t, st, 'r');  hold on
plot(t, lh, 'Color',co(5,:))
plot(t, rh, 'Color',co(1,:))
ylim([-30 +30]);  grid on;  hold off

title('Eye Movement')
xlabel('Time (s)',             'FontWeight','bold')
ylabel('Eye Position (\circ)', 'FontWeight','bold')
legend('Target', 'Left Eye', 'Right Eye')

dataPlotter()
