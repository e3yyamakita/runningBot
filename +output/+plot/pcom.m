function pcom(result)

len = length(result.time);
pcom = zeros(len, 2);
ddpcom = zeros(len, 2);
for k=2:len
  pcom_k = result.calc_pcom(k);
  pcom(k,:) = pcom_k;
  %ddpcom(k,:) = ddpcom_k;
end

figure;

subplot(2,1,1);
hold on
plot(result.time,pcom(:,1));
plot(result.time,pcom(:,2));
legend("pcom");
title("pcom");
xlabel('time [t]'); ylabel('pcom [m]');
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