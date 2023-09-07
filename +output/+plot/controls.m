function controls(result)
figure;
u = [result.u1; result.u2; result.u3; result.u4; result.u5; result.u6];
hold on
title('torque');
for i=1:6
  plot(result.control_time, u(i,:));
end
legend('u1','u2','u3','u4','u5','u6');
xlabel('time [t]'); ylabel('u [Nm]');
ylim([-300, 300]);
xlim([0, result.control_time(end)]);
result.separate_background_with_section('control');

figure;
plot(result.control_time, result.uw);
title('uw');
xlabel('time [t]'); ylabel('u_w [N]');
result.separate_background_with_section('control');

end