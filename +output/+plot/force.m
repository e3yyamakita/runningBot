function force(result)
figure;

hold on
subplot(3,1,1);
plot(result.algvars_time, result.fex);
title('fex');
xlabel('time [t]'); ylabel('force [N]');
result.separate_background_with_section('algvars');

subplot(3,1,2);
plot(result.algvars_time, result.fey);
title('fey');
xlabel('time [t]'); ylabel('force [N]');
result.separate_background_with_section('algvars');

subplot(3,1,3);
plot(result.algvars_time, result.feth);
title('feth');
xlabel('time [t]'); ylabel('force [Nm]');
result.separate_background_with_section('algvars');

end