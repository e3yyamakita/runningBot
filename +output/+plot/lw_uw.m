function lw_uw(result)

figure;

subplot(2,1,1);
ylim([0.195 0.225])
plot(result.time,result.lw);
legend("lw");
title("lw");
xlabel('time [t]'); ylabel('lw [m]');
xlim([0, result.time(end)]);
result.separate_background_with_section('state');

subplot(2,1,2);
plot(result.control_time, result.uw);
title('uw');
xlabel('time [t]'); ylabel('u_w [N]');
xlim([0, result.control_time(end)]);
result.separate_background_with_section('control');

end