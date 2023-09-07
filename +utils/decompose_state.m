function [q, dq, phi, dphi] = decompose_state(x)
  q = [
    x.xb;
    x.yb;
    x.thb;
    x.lw;
    x.th1;
    x.th2;
    x.th3;
    x.th4;
    x.th5;
    x.th6
    ];
  dq = [
    x.dxb;
    x.dyb;
    x.dthb;
    x.dlw;
    x.dth1;
    x.dth2;
    x.dth3;
    x.dth4;
    x.dth5;
    x.dth6
    ];

  phi = [
    x.phi1;
    x.phi2;
    x.phi3;
    x.phi4;
    x.phi5;
    x.phi6
    ];
  dphi = [
    x.dphi1;
    x.dphi2;
    x.dphi3;
    x.dphi4;
    x.dphi5;
    x.dphi6
    ];
end