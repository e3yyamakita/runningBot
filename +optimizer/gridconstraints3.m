%% 立脚期(最初)のgridconstraints

function gridconstraints3(conh, k, K, x, p)
  tic;
  global q0 phi0 dq0 dphi0 
  global ppphi pphi
  global flags

  %% 共通部分
  [q, dq, phi, dphi] = utils.decompose_state(x);
  pj = SEA_model.pj(params,x);
  dpj = SEA_model.dpj(params,x);
  optimizer.gridconstraints_base(conh, q, phi, pj, dpj, x);

  %% 各関節が地面より上(y座標制約)
  conh.add(pj(1,2),'>=',0); % 支持脚ひざ
  conh.add(pj(3,2),'==',0); % 支持脚つまさき
  conh.add(pj(4,2),'>',0);  % 支持脚かかと


  conh.add(pj(5,2),'>=',0);
  
  conh.add(pj(7,2),'>=',0); % 遊脚つまさき
  conh.add(pj(8,2),'>=',0); % 遊脚かかと
  
  %% 遊脚前進制約
  conh.add(dpj(6,1),'>=',0);

  conh.add(ppphi-2*pphi+phi,'<=',2) %滑らか制約
  conh.add(ppphi-2*pphi+phi,'>=',-2)
  ppphi = pphi;
  pphi = phi;
    
  fprintf('gridconstraints3(k=%2d) complete : %.2f seconds\n',k,toc);
end
