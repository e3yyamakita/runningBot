function plot_result(result)
close all;

%default_color = get(0, 'DefaultFigureColor');
%set(0, 'DefaultFigureColor', 'w');
% plot lw
output.plot.lw(result);

% plot pb
output.plot.pb(result);

% plot pj
output.plot.pj(result);

% plot theta and phi
output.plot.theta_phi(result);

% plot controls
output.plot.controls(result);

% plot force
output.plot.force(result);

% print params
output.print_param(result);

%set(0, 'DefaultFigureColor', default_color);

end