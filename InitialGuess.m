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
    kknee
    khip
    kankle
    mw
    beta_ankle % inerters
    beta_knee
  end
  properties (Constant)
    zmp_x = [0, params.l3-params.a3];
    fex = [100, 100];
    fey = [500, 500];
  end
  methods
    function ig = InitialGuess(step, draw)
      ig.xb = [-step/3,-step/3,step/4,step*2/3];
      ig.yb = [sqrt(0.8^2-(step/3)^2),sqrt(0.8^2-(step/3)^2),sqrt(0.8^2-(step/4)^2),sqrt(0.8^2-(step/3)^2)];
      ig.thb = [pi,pi,pi,pi]*2/5;
      ig.lw = [0.4, 0.4, 0.4, 0.4]*params.l7;
      ig.th1 = [asin(step/3/0.8),asin(step/3/0.8),-asin(step/4/0.8),-asin(step/3/0.8)]+(pi+(pi/2-ig.thb));
      ig.th2 = [0,0,0,-pi/4];
      ig.th3 = [acos(step/3/0.8),acos(step/3/0.8),pi-acos(step/4/0.8),pi-acos(step/3/0.8)];
      ig.th4 = [-asin(step/3/0.8),-asin(step/3/0.8),asin(step/4/0.8)+pi/5,asin(step/3/0.8)]+(pi+(pi/2-ig.thb));
      ig.th5 = [-pi/4,-pi/4,-pi*3/5,0];
      ig.th6 = [pi-acos(step/3/0.8),pi-acos(step/3/0.8),acos(step/4/0.8),acos(step/3/0.8)];
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
    
    function set_initial_guess(obj, mode1, mode2, mode3, period, tiptoe_duration)
      period1 = period*0.5;
      period2 = period*0.5;
      period = [tiptoe_duration, period1, period2];
      utils.set_initial_guess(mode1, 1, obj, period);
      utils.set_initial_guess(mode2, 2, obj, period);
      utils.set_initial_guess(mode3, 3, obj, period);
    end
  end
end