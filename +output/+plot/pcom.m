function pcom(result)
len = length(result.time);
pcom = zeros(len, 2);
dpcom = zeros(len, 2);
for k=1:len
  pcom_k = result.calc_pcom(k);
  pcom(k,:) = pcom_k;
  
  dpcom_k = result.calc_dpcom(k);
  dpcom(k,:) = dpcom_k;
  %ddpcom(k,:) = ddpcom_k;
end

figure;
subplot(2,2,1);
hold on
plot(result.time,pcom(:,1));
legend("pcom");
title("pcom");
xlabel('time [t]'); ylabel('pcom [m]');
title("CoM horizontal position");
result.separate_background_with_section('state');

subplot(2,2,2);
hold on
plot(result.time,dpcom(:,1));
legend("pcom");
title("CoM horizontal velocity");
xlabel('time [t]'); ylabel('CoM velocity [m/s]');
result.separate_background_with_section('state');

subplot(2,2,3);
hold on
plot(result.time,pcom(:,2));
legend("pcom");
title("pcom");
xlabel('time [t]'); ylabel('pcom [m]');
title("CoM vertical position");
result.separate_background_with_section('state');

subplot(2,2,4);
hold on
plot(result.time,dpcom(:,2));
legend("pcom");
title("CoM vertical velocity");
xlabel('time [t]'); ylabel('CoM velocity [m/s]');
result.separate_background_with_section('state');
%{
subplot(2,1,2);
hold on
plot(result.time,ddpcom(:,1));
plot(result.time,ddpcom(:,2));
legend("ddpcom");
title("ddpcom");
xlabel('time [t]'); ylabel('ddpcom [m/s^2]');
result.separate_background_with_section('state');
end
%}