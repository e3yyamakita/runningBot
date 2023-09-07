function theta_phi(result)

figure;
% plot theta
th = [result.th1; result.th2; result.th3; result.th4; result.th5; result.th6];
subplot(2,1,1);
hold on
title('theta');
for i=1:6
  plot(result.time, th(i,:));
end
legend('th1','th2','th3','th4','th5','th6');
xlabel('time');
result.separate_background_with_section('state');


% plot phi
subplot(2,1,2);
hold on
title('phi');
phi = [result.phi1; result.phi2; result.phi3; result.phi4; result.phi5; result.phi6];
for i=1:6
  plot(result.time, phi(i,:));
end
legend('phi1','phi2','phi3','phi4','phi5','phi6');
xlabel('time');
result.separate_background_with_section('state');

figure;
for i=1:6
  subplot(3,2,i);
  plot(result.time, th(i,:));
  hold on
  plot(result.time, phi(i,:));
  title(strcat('joint ', num2str(i)));
  xlabel('time');
  legend('theta','phi');
  result.separate_background_with_section('state');
end


% plot theta
dth = [result.dth1; result.dth2; result.dth3; result.dth4; result.dth5; result.dth6];
figure;
subplot(2,1,1);
hold on
title('dtheta');
for i=1:6
  plot(result.time, dth(i,:));
end
legend('dth1','dth2','dth3','dth4','dth5','dth6');
xlabel('time');
result.separate_background_with_section('state');


% plot phi
subplot(2,1,2);
hold on
title('dphi');
dphi = [result.dphi1; result.dphi2; result.dphi3; result.dphi4; result.dphi5; result.dphi6];
for i=1:6
  plot(result.time, dphi(i,:));
end
legend('dphi1','dphi2','dphi3','dphi4','dphi5','dphi6');
xlabel('time');
result.separate_background_with_section('state');


figure;
for i=1:6
  subplot(3,2,i);
  plot(result.time, dth(i,:));
  hold on
  plot(result.time, dphi(i,:));
  title(strcat('joint ',num2str(i)));
  xlabel('time');
  legend('dtheta','dphi');
  result.separate_background_with_section('state');
end


end