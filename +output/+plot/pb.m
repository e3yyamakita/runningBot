function pb(result)
% plot xb,yb
figure;
subplot(3,2,1); plot(result.time, result.xb);
title('xb'); xlabel('time'); result.separate_background_with_section('state');

subplot(3,2,2); plot(result.time, result.dxb);
title('dxb'); xlabel('time'); result.separate_background_with_section('state');

subplot(3,2,3); plot(result.time, result.yb);
title('yb'); xlabel('time'); result.separate_background_with_section('state');

subplot(3,2,4); plot(result.time, result.dyb); 
title('dyb'); xlabel('time'); result.separate_background_with_section('state');

subplot(3,2,5); plot(result.time, result.thb);
title('thb'); xlabel('time'); result.separate_background_with_section('state');

subplot(3,2,6); plot(result.time, result.dthb);
title('dthb'); xlabel('time'); result.separate_background_with_section('state');

end

