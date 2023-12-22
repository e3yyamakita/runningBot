function dae3(daeh,x,z,u,p)
  tic;
  
  global flags
  
  % 共通部分
  optimizer.dae_base(daeh, x, z, u, p);
  
  [q, dq, phi, ~] = utils.decompose_state(x);
  
  [ddq, ddphi] = utils.decompose_algvars(z);

  U = [u.u1; u.u2; u.u3; u.u4; u.u5; u.u6;];

  if flags.optimize_k
    % spring sttifness of SEA
    K = diag(repmat([x.khip x.kknee x.kankle],1,2));
    % inertia of SEA
    B = diag(repmat([params.bhip params.bknee params.bankle],1,2));
  else
    K = diag(repmat([params.khip params.kknee params.kankle],1,2));
    B = diag(repmat([params.bhip params.bknee params.bankle],1,2));
  end

  S = params.S;
  % wobbling mass
  uw = u.uw;

  M = SEA_model.M(params,x,p);
  h = SEA_model.h(params,x,z,p);

  if flags.optimize_mw
    m = [params.m1;params.m2;params.m3;params.m4;params.m5;params.m6;params.m7;x.mw];
  else
    m = [params.m1;params.m2;params.m3;params.m4;params.m5;params.m6;params.m7;params.mw];
  end
  I = [params.i1;params.i2;params.i3;params.i4;params.i5;params.i6;params.i7];

  g = params.g;

  
  thb = q(3); dthb = dq(3); ddthb = ddq(3);
  th = q(4+1:4+6); dth = dq(4+1:4+6); ddth = ddq(4+1:4+6);
  [~, ~, ddth_abs] = utils.calculate_absolute_angle(th, dth, ddth, thb, dthb, ddthb);
  pc = SEA_model.pc(params,x,z);
  pw = SEA_model.pw(params,x,z);
  pcx = [pc(:,1); pw(1)];
  pcy = [pc(:,2); pw(2)];
  ddpc = SEA_model.ddpc(params,x,z);
  ddpw = SEA_model.ddpw(params,x,z);
  ddpcx = [ddpc(:,1); ddpw(1)];
  ddpcy = [ddpc(:,2); ddpw(2)];
  pcom = SEA_model.pcom(params,x,z,p);
  ddpcom = SEA_model.ddpcom(params,x,z,p);
  xcom = pcom(1); ycom = pcom(2);
  ddxcom = ddpcom(1); ddycom = ddpcom(2);

  Jc1 = SEA_model.Jc1(params,x);
  dJc1 = SEA_model.dJc1(params,x);
  
  
  if flags.use_ankle_sea
    tau = K*(phi-q(5:10,:));
  else 
    tau = K*(phi-q(5:10,:));
    tau(3) = U(3);
    tau(6) = U(6);
  end
  
  tau2 = [uw;tau];
  if flags.runtype == 1
      Jtoe = SEA_model.Jtoe(params,x,z);
      dJtoe = SEA_model.dJtoe(params,x,z);
      fe = [z.fex*z.fey; z.fey];
      DAE1 = [M,-Jtoe.'; Jtoe,zeros(2,2)]*[ddq;fe] - [S*tau2-h; -dJtoe*dq];
  elseif flags.runtype == 2    
      Jheel = SEA_model.Jheel(params,x,z);
      dJheel = SEA_model.dJheel(params,x,z);
      fe = [z.fex*z.fey; z.fey];
      DAE1 = [M,-Jheel.'; Jheel,zeros(2,2)]*[ddq;fe] - [S*tau2-h; -dJheel*dq];
  end
  
  DAE2 = B*ddphi - (U-tau);
  if ~flags.use_ankle_sea
      DAE2(3) = ddphi(3);
      DAE2(6) = ddphi(6);
  end
  DAE3 = [z.feth];
  
  daeh.setAlgEquation(DAE1(1));
  daeh.setAlgEquation(DAE1(2));
  daeh.setAlgEquation(DAE1(3));
  if(flags.use_wobbling_mass)
    daeh.setAlgEquation(DAE1(4));
  else
    DAE4 = [z.ddlw];
    daeh.setAlgEquation(DAE4);
  end
  daeh.setAlgEquation(DAE1(5));
  daeh.setAlgEquation(DAE1(6));
  daeh.setAlgEquation(DAE1(7));
  daeh.setAlgEquation(DAE1(8));
  daeh.setAlgEquation(DAE1(9));
  daeh.setAlgEquation(DAE1(10));
  daeh.setAlgEquation(DAE2(1));
  daeh.setAlgEquation(DAE2(2));
  daeh.setAlgEquation(DAE2(3));
  daeh.setAlgEquation(DAE2(4));
  daeh.setAlgEquation(DAE2(5));
  daeh.setAlgEquation(DAE2(6));
  daeh.setAlgEquation(DAE3(1));
  daeh.setAlgEquation(DAE1(11));
  daeh.setAlgEquation(DAE1(12));
  
  fprintf('dae3                   complete : %.2f seconds\n',toc);
end
