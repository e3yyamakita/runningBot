%% animation
% argument
% result: instance of Result class which is the result of optimization
% loop: the number of steps of animation
% playratio: ratio to vary time axis.
% save_video: true or false
% filename: save video filename

%%
function animation(result, loop, playratio, save_video, filename)
set(0, 'DefaultLineLineWidth', 1);
close all;
f = figure;
%f.Position = f.Position +[-500 -500 500 200];
plot([-10 10],[0 0],'k')
hold on
axis equal
ylim([-0.2 1.8])
xlim([-0.8 result.step*loop+0.5])
formatSpec = 'Forefoot, 8m/s; time: %.4f';
title_handle = title(sprintf(formatSpec, 0.0));


rate = 60;
v_period = 1/rate*playratio;
set(0, 'DefaultLineLineWidth', 2);

pause(1)

if save_video
    disp('Saving movie')
    v=VideoWriter(filename, 'MPEG-4');
    v.FrameRate = rate;
    open(v)
    mov = getframe(f);
    writeVideo(v,mov);
end

for n=1:loop
  xb   = result.xb;
  yb   = result.yb;
  thb  = result.thb;
  lw   = result.lw;
  th1  = result.th1;
  th2  = result.th2;
  th3  = result.th3;
  th4  = result.th4;
  th5  = result.th5;
  th6  = result.th6;
  % time = times.states.value;
  time =  result.time;
  step = result.step;
  
  k = 1;
  k2 = 1;
  for t = 0:v_period:time(end)
      q = [xb(k)+(n-1)*step;yb(k);thb(k);lw(k);th1(k);th2(k);th3(k);th4(k);th5(k);th6(k)];
      th_abs = [
          q(3) + q(5);
          q(3) + q(5) + q(6);
          q(3) + q(5) + q(6) + q(7);
          q(3) + q(8);
          q(3) + q(8) + q(9);
          q(3) + q(8) + q(9) + q(10);
          q(3)
          ];
      lwm = q(4);
      pb = [q(1) q(2)];

      pj(1,:) = pb      +  params.l1              * [cos(th_abs(1)) sin(th_abs(1))]; %leg1 knee
      pj(2,:) = pj(1,:) +  params.l2              * [cos(th_abs(2)) sin(th_abs(2))]; %leg1 ankle
      pj(3,:) = pj(2,:) + (params.l3 - params.c1) * [cos(th_abs(3)) sin(th_abs(3))]; %leg1 toe
      pj(4,:) = pj(2,:) -  params.c1              * [cos(th_abs(3)) sin(th_abs(3))]; %leg1 heel
      pj(5,:) = pb      +  params.l4              * [cos(th_abs(4)) sin(th_abs(4))]; %leg2 knee
      pj(6,:) = pj(5,:) +  params.l5              * [cos(th_abs(5)) sin(th_abs(5))]; %leg2 ankle
      pj(7,:) = pj(6,:) + (params.l6 - params.c2) * [cos(th_abs(6)) sin(th_abs(6))]; %leg2 toe
      pj(8,:) = pj(6,:) -  params.c2              * [cos(th_abs(6)) sin(th_abs(6))]; %leg2 heel
      pj(9,:) = pb      +  params.l7              * [cos(th_abs(7)) sin(th_abs(7))]; %head
      pj(10,:) = pb      + (params.l7 - lwm    )  * [cos(th_abs(7)) sin(th_abs(7))];

      % pcom = result.calc_pcom(k)+[(n-1)*step, 0];
      
%       if (k2 > result.algvars_size(1)) &&(result.flags.forefoot)
%         zmp_x = result.zmp_x(k2-result.algvars_size(1)) + (n-1)*step;
%       elseif ~(result.flags.forefoot)
%           zmp_x = result.zmp_x(k2) + (n-1)*step;
%       else
%           zmp_x = 0;
%       end

      if t > 0
          pause(v_period/playratio-toc);
          delete(l1);
          delete(l2);
          delete(l3);
          delete(l4);
          delete(l5);
          delete(l6);
          delete(l7);
          delete(l8);
          %delete(l9);
          
          %delete(l10);
      end
      
      % 現在時刻がtime(k)を上回ったらkをインクリメント
      while(t>=time(k) && k < length(time))
        k = k + 1;
      end
      % 現在時刻がresult.algvars_time(k2)を上回ったらk2をインクリメント
      if result.flags.forefoot
          while(t>=result.algvars_time(k2) && k2 < result.algvars_size(1)+result.algvars_size(2)+result.algvars_size(3))
            k2 = k2 + 1;
          end
      else
        while(t>=result.algvars_time(k2) && k2 < result.algvars_size(1))
            k2 = k2 + 1;
        end
      end
      tic;
      hold on;
      l1 = line([q(1)   ,pj(1,1)],[q(2)   ,pj(1,2)]);
      l2 = line([pj(1,1),pj(2,1)],[pj(1,2),pj(2,2)]);
      l3 = line([pj(3,1),pj(4,1)],[pj(3,2),pj(4,2)]);
      l4 = line([q(1)   ,pj(5,1)],[q(2)   ,pj(5,2)]);
      l5 = line([pj(5,1),pj(6,1)],[pj(5,2),pj(6,2)]);
      l6 = line([pj(7,1),pj(8,1)],[pj(7,2),pj(8,2)]);
      l7 = line([q(1)   ,pj(9,1)],[q(2)   ,pj(9,2)]);
      l8 = plot(pj(10,1),pj(10,2),'o','color',[38,124,185]/255,'MarkerSize',7);
      %l9 = plot(0, 0, '.', 'color', 'k', 'MarkerSize', 0.01);
%       if t < result.algvars_time(result.algvars_size(1)+result.algvars_size(2)) && ...
%          (t < result.algvars_time(result.algvars_size(1)) || ~result.flags.forefoot) 
%          l9 = plot(zmp_x, 0, 'o', 'color', 'r', 'MarkerSize', 2);
%       end
      %l10 = plot(pcom(1), pcom(2) ,'o','color','y','MarkerSize',5);
      
      %{
      f1.XData = pj(2,1); f1.YData = pj(2,2);
      f1.UData = result.f1x(k2); f1.VData = result.f1y(k2);
      f2.XData = pj(6,1); f2.YData = pj(6,2);
      f2.UData = result.f2x(k2); f2.VData = result.f2y(k2);
      %}
      %l8 = line([pj(10,1),pj(10,1)],[pj(10,2),pj(10,2)],'marker','o');
      %pause(0.3)
      title_handle.String = sprintf(formatSpec, t+time(end)*(n-1));
      if save_video
        mov = getframe(f);
        writeVideo(v, mov);
      end
      drawnow
  end
  if n~=loop
    delete(l1);
    delete(l2);
    delete(l3);
    delete(l4);
    delete(l5);
    delete(l6);
    delete(l7);
    delete(l8);
    %delete(l9);
    %delete(l10);
end
  if save_video && n==loop
      close(v);
      disp('Finished!')
  end
  set(0, 'DefaultLineLineWidth', 1);
end
