%% 立脚期から浮遊期への遷移

function trans_stand2float(ch, x0, xF)
% x0 current stage
% xF previous stage
global flags
ch.add(x0.xb  , '==', xF.xb  );
ch.add(x0.yb  , '==', xF.yb  );
ch.add(x0.thb , '==', xF.thb );
ch.add(x0.lw  , '==', xF.lw  );
ch.add(x0.th1 , '==', xF.th1 );
ch.add(x0.th2 , '==', xF.th2 );
ch.add(x0.th3 , '==', xF.th3 );
ch.add(x0.th4 , '==', xF.th4 );
ch.add(x0.th5 , '==', xF.th5 );
ch.add(x0.th6 , '==', xF.th6 );
ch.add(x0.phi1, '==', xF.phi1);
ch.add(x0.phi2, '==', xF.phi2);
ch.add(x0.phi3, '==', xF.phi3);
ch.add(x0.phi4, '==', xF.phi4);
ch.add(x0.phi5, '==', xF.phi5);
ch.add(x0.phi6, '==', xF.phi6);
ch.add(x0.dxb  , '==', xF.dxb  );
ch.add(x0.dyb  , '==', xF.dyb  );
ch.add(x0.dthb , '==', xF.dthb );
ch.add(x0.dlw  , '==', xF.dlw  );
ch.add(x0.dth1 , '==', xF.dth1 );
ch.add(x0.dth2 , '==', xF.dth2 );
ch.add(x0.dth3 , '==', xF.dth3 );
ch.add(x0.dth4 , '==', xF.dth4 );
ch.add(x0.dth5 , '==', xF.dth5 );
ch.add(x0.dth6 , '==', xF.dth6 );
ch.add(x0.dphi1, '==', xF.dphi1);
ch.add(x0.dphi2, '==', xF.dphi2);
ch.add(x0.dphi3, '==', xF.dphi3);
ch.add(x0.dphi4, '==', xF.dphi4);
ch.add(x0.dphi5, '==', xF.dphi5);
ch.add(x0.dphi6, '==', xF.dphi6);
if flags.optimize_k
  ch.add(x0.khip, '==', xF.khip);
  ch.add(x0.kknee, '==', xF.kknee);
  ch.add(x0.kankle, '==', xF.kankle);
end
if flags.optimize_mw
  ch.add(x0.mw, '==', xF.mw);
end
ch.add(x0.time,'==',xF.time);
ch.add(x0.period, '==', xF.period);
end