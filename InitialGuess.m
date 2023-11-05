classdef InitialGuess
  properties
    xb
    yb
    thb
    lw
    th1
    th2
    th3
    th4
    th5
    th6
    phi1
    phi2
    phi3
    phi4
    phi5
    phi6
    u1
    u2
    u3
    u4
    u5
    u6
    uw
    kknee
    khip
    kankle
    mw
    beta_ankle % inerters
    beta_knee
    period
  end
  properties (Constant)
    zmp_x = [0, params.l3-params.a3];
    fex = [100, 100];
    fey = [500, 500];
  end
  methods
    function ig = InitialGuess(step, draw)
        global mode1N mode2N mode3N
%       ig.xb = [-step/3,-step/3,step/4,step*2/3];
%       ig.yb = [sqrt(0.8^2-(step/3)^2),sqrt(0.8^2-(step/3)^2),sqrt(0.8^2-(step/4)^2),sqrt(0.8^2-(step/3)^2)];
%       ig.thb = [pi,pi,pi,pi]*2/5;
%       ig.lw = [0.4, 0.4, 0.4, 0.4]*params.l7;
%       ig.th1 = [asin(step/3/0.8),asin(step/3/0.8),-asin(step/4/0.8),-asin(step/3/0.8)]+(pi+(pi/2-ig.thb));
%       ig.th2 = [0,0,0,-pi/4];
%       ig.th3 = [acos(step/3/0.8),acos(step/3/0.8),pi-acos(step/4/0.8),pi-acos(step/3/0.8)];
%       ig.th4 = [-asin(step/3/0.8),-asin(step/3/0.8),asin(step/4/0.8)+pi/5,asin(step/3/0.8)]+(pi+(pi/2-ig.thb));
%       ig.th5 = [-pi/4,-pi/4,-pi*3/5,0];
%       ig.th6 = [pi-acos(step/3/0.8),pi-acos(step/3/0.8),acos(step/4/0.8),acos(step/3/0.8)];
      
      %load("slow_init.mat",'result');
      load("fast_init.mat",'result');
      %load("noninerter_forfoot.mat",'result');
      %load("aoyama_ver_result.mat",'result');
      %load("close_result.mat",'result');
      ig.xb = [result.xb(1),result.xb(2),result.xb(1)+step/2,result.xb(1)+step];
      ig.yb = [result.yb(1),result.yb(2),result.yb(sum(result.control_size([1,2]))),result.yb(1)];
      ig.thb = [result.thb(1),result.thb(2),result.thb(sum(result.control_size([1,2]))),result.thb(1)];
      ig.lw = [result.lw(1),result.lw(2),result.lw(sum(result.control_size([1,2]))),result.lw(1)];
      ig.th1 = [result.th1(1),result.th1(2),result.th1(sum(result.control_size([1,2]))),result.th4(1)];
      ig.th2 = [result.th2(1),result.th2(2),result.th2(sum(result.control_size([1,2]))),result.th5(1)];
      ig.th3 = [result.th3(1),result.th3(2),result.th3(sum(result.control_size([1,2]))),result.th6(1)];
      ig.th4 = [result.th4(1),result.th4(2),result.th4(sum(result.control_size([1,2]))),result.th1(1)];
      ig.th5 = [result.th5(1),result.th5(2),result.th5(sum(result.control_size([1,2]))),result.th2(1)];
      ig.th6 = [result.th6(1),result.th6(2),result.th6(sum(result.control_size([1,2]))),result.th3(1)];
      ig.u1 = [result.u1(1),result.u1(2),result.u1(sum(result.control_size([1,2]))),result.u1(1)];
      ig.u2 = [result.u2(1),result.u2(2),result.u2(sum(result.control_size([1,2]))),result.u2(1)];
      ig.u3 = [result.u3(1),result.u3(2),result.u3(sum(result.control_size([1,2]))),result.u3(1)];
      ig.u4 = [result.u4(1),result.u4(2),result.u4(sum(result.control_size([1,2]))),result.u4(1)];
      ig.u5 = [result.u5(1),result.u5(2),result.u5(sum(result.control_size([1,2]))),result.u5(1)];
      ig.u6 = [result.u6(1),result.u6(2),result.u6(sum(result.control_size([1,2]))),result.u6(1)];
      ig.uw = [result.uw(1),result.uw(2),result.uw(sum(result.control_size([1,2]))),result.uw(1)];
      
      ig.phi1 = ig.th1;
      ig.phi2 = ig.th2;
      ig.phi3 = ig.th3;
      ig.phi4 = ig.th4;
      ig.phi5 = ig.th5;
      ig.phi6 = ig.th6;
      ig.khip = params.khip;
      ig.kknee = params.kknee;
      ig.kankle = params.kankle;
      ig.mw = 0.5;
      ig.beta_ankle = 0.5;
      ig.beta_knee = 0.5;
      ig.period = [0,0,0];
      if draw
        ig.draw();
      end
    end
    
    function draw(obj)
      figure;
      plot([-10 10],[0 0],'k')
      hold on; axis equal;
      ylim([-0.2 1.5]); xlim([-1.2 1.2]);
      r = linspace(0, 1, length(obj.xb));
      b = linspace(0, 1, length(obj.xb));
      for k=1:length(obj.xb)
        q = [obj.xb(k);obj.yb(k);obj.thb(k);obj.lw(k); ...
             obj.th1(k);obj.th2(k);obj.th3(k);obj.th4(k);obj.th5(k);obj.th6(k)];
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

        color = [r(k), 0.3, b(k)];
        l1 = line([q(1)   ,pj(1,1)],[q(2)   ,pj(1,2)],'Color', color);
        l2 = line([pj(1,1),pj(2,1)],[pj(1,2),pj(2,2)],'Color', color);
        l3 = line([pj(3,1),pj(4,1)],[pj(3,2),pj(4,2)],'Color', color);
        l4 = line([q(1)   ,pj(5,1)],[q(2)   ,pj(5,2)],'Color', color);
        l5 = line([pj(5,1),pj(6,1)],[pj(5,2),pj(6,2)],'Color', color);
        l6 = line([pj(7,1),pj(8,1)],[pj(7,2),pj(8,2)],'Color', color);
        l7 = line([q(1)   ,pj(9,1)],[q(2)   ,pj(9,2)],'Color', color);
        l8 = plot(pj(10,1),pj(10,2),'o','Color',color,'MarkerSize',10);
        l9 = plot(pj(6, 1),pj(6, 2),'*','Color',color,'MarkerSize',6);
      end
    end
    
    function set_initial_guess(obj, mode1, mode2, mode3, period, tiptoe_dur)
      period1 = period*0.4;
      period2 = period*0.6;
      obj.period = [tiptoe_dur, period1, period2];
      utils.set_initial_guess(mode1, 1, obj, obj.period);
      utils.set_initial_guess(mode2, 2, obj, obj.period);
      utils.set_initial_guess(mode3, 3, obj, obj.period);
    end
  end
end