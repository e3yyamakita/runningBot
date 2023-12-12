%% Forefootのgridconstraints

function gridconstraints3(conh, k, K, x, p)
  tic;
  global q0 phi0 dq0 dphi0 pdlw ppdlw
  global ppphi pphi
  global flags

  %% 共通部分
  [q, dq, phi, dphi] = utils.decompose_state(x);
  pj = SEA_model.pj(params,x);
  dpj = SEA_model.dpj(params,x);
  optimizer.gridconstraints_base(conh, q, phi, pj, dpj, x, p);

  %% 各関節が地面より上(y座標制約)
  conh.add(pj(1,2),'>=',0); % Supp Knee
  %conh.add(pj(2,2),'>=',0); % Supp ankle
  conh.add(pj(3,2),'==',0); % Supp Toe
  if k == 1
    conh.add(pj(4,2),'==',0);  % Supp heel
  elseif ~(k==1) 
    conh.add(pj(4,2),'>=',0); % Supp heel
  end
  
  conh.add(dq(8),'>=',0);
  
  conh.add(pj(5,2),'>=',0); % Swng Knee
  %conh.add(pj(6,2),'>=',0); % Swng ankle
  conh.add(pj(7,2),'>=',0); % Swng Toe
  conh.add(pj(8,2),'>=',0); % Swng heel
  
  conh.add(dpj(6,1),'>=',0);
  
  %% 遊脚前進制約

  conh.add(ppdlw-2*pdlw+dq(4),'<=',2) %滑らか制約
  conh.add(ppdlw-2*pdlw+dq(4),'>=',-2)
  ppdlw = pdlw;
  pdlw = dq(4);
    
  
  if flags.use_ankle_sea  
      conh.add(ppphi-2*pphi+phi,'<=',2) %滑らか制約
      conh.add(ppphi-2*pphi+phi,'>=',-2)
  else
      conh.add(ppphi-2*pphi+phi([1,2,4,5]),'<=',2) %滑らか制約
      conh.add(ppphi-2*pphi+phi([1,2,4,5]),'>=',-2)    
  end
  ppphi = pphi;
  if flags.use_ankle_sea
    pphi = phi;
  else
    pphi = phi([1,2,4,5]);
  end
  fprintf('gridconstraints4(k=%2d) complete : %.2f seconds\n',k,toc);
end
