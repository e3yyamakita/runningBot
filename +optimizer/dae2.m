function dae2(daeh,x,z,u,p)
  tic;
  
  global flags;
  
  % 共通部分
  optimizer.dae_base(daeh, x, z, u, p);
  
  
  [q, ~, phi, ~] = utils.decompose_state(x);
  
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

  M = SEA_model.M(params,x);
  h = SEA_model.h(params,x,z);
  if flags.use_inerter
    % bm = Inerter_model.bm(0,x.beta,x.beta,0,x.beta,x.beta);
    beta_ankle = x.beta_ankle;
    beta_knee = x.beta_knee;
   bm = [0,0,0,0,0,        0,         0,          0,        0,          0;
         0,0,0,0,0,        0,         0,          0,        0,          0;
         0,0,0,0,0,        0,         0,          0,        0,          0;
         0,0,0,0,0,        0,         0,          0,        0,          0;
         0,0,0,0,0,        0,         0,          0,        0,          0;
         0,0,0,0,0,beta_knee,         0,          0,        0,          0;
         0,0,0,0,0,        0,beta_ankle,          0,        0,          0;
         0,0,0,0,0,        0,         0,          0,        0,          0;
         0,0,0,0,0,        0,         0,          0,beta_knee,          0;
         0,0,0,0,0,        0,         0,          0,        0, beta_ankle];
    % bm = [0,0,0,0,0,        0,         0,          0,        0,           0;
    %      0,0,0,0,0,        0,         0,          0,        0,           0;
    %      0,0,0,0,0,        0,         0,          0,        0,           0;
    %      0,0,0,0,0,        0,         0,          0,        0,           0;
    %      0,0,0,0,0,beta_knee,         0,          0,        0,           0;
    %      0,0,0,0,0,-beta_knee,  beta_ankle,          0,        0,          0;
    %      0,0,0,0,0,        0, -beta_ankle,          0,        0,          0;
    %      0,0,0,0,0,        0,         0,          0,  beta_knee,            0;
    %      0,0,0,0,0,        0,         0,          0, -beta_knee,   beta_ankle;
    %      0,0,0,0,0,        0,         0,          0,        0,   -beta_ankle];
  end

  if flags.use_sea
    tau = K*(phi-q(5:10,:));
  else
    tau = U;
  end
  tau2 = [uw;tau];
  if flags.use_inerter
    DAE1 = (M+bm)*ddq -(S*tau2-h);
  else
    DAE1 = M*ddq -(S*tau2-h);
  end
  DAE2 = B*ddphi - (U-tau);
  DAE3 = [z.fex; z.fey; z.feth];
  
  daeh.setAlgEquation(DAE1(1));
  daeh.setAlgEquation(DAE1(2));
  daeh.setAlgEquation(DAE1(3));
  daeh.setAlgEquation(DAE1(4));
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
  daeh.setAlgEquation(DAE3(2));
  daeh.setAlgEquation(DAE3(3));
  
  fprintf('dae2                   complete : %.2f seconds\n',toc);
end
