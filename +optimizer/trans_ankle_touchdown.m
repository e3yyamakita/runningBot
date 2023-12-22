%% 立脚期から浮遊期への遷移

function trans_ankle_touchdown(ch, x0, xF)
% x0 current stage
% xF previous stage
global flags
M = SEA_model.M(params,x0);
Jc1 = SEA_model.Jc1(params,x0);
[q, dq, phi, dphi] = utils.decompose_state(x0);

dq_after_lambda = [M,-Jc1.'; Jc1,zeros(3,3)] \ [M*dq; zeros(3,1)];
dq_after = dq_after_lambda(1:10);

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
ch.add(dq_after(1)  , '==', xF.dxb  );
ch.add(dq_after(2)  , '==', xF.dyb  );
ch.add(dq_after(3) , '==', xF.dthb );
ch.add(dq_after(4)  , '==', xF.dlw  );
ch.add(dq_after(5) , '==', xF.dth1 );
ch.add(dq_after(6) , '==', xF.dth2 );
ch.add(dq_after(7) , '==', xF.dth3 );
ch.add(dq_after(8) , '==', xF.dth4 );
ch.add(dq_after(9) , '==', xF.dth5 );
ch.add(dq_after(10) , '==', xF.dth6 );
ch.add(x0.dphi1, '==', xF.dphi1);
ch.add(x0.dphi2, '==', xF.dphi2);
ch.add(x0.dphi3, '==', xF.dphi3);
ch.add(x0.dphi4, '==', xF.dphi4);
ch.add(x0.dphi5, '==', xF.dphi5);
ch.add(x0.dphi6, '==', xF.dphi6);
ch.add(x0.time, '==', xF.time);

if flags.optimize_k
  ch.add(x0.khip, '==', xF.khip);
  ch.add(x0.kknee, '==', xF.kknee);
  ch.add(x0.kankle, '==', xF.kankle);
end
if flags.optimize_mw
  ch.add(x0.mw, '==', xF.mw);
end


end