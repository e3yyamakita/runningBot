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
  %conh.add(pj(1,2),'>=',0); % Supp Knee
  %conh.add(pj(2,2),'>=',0); % Supp ankle
  conh.add(pj(3,2),'==',0); % Supp Toe
  conh.add(pj(4,2),'>=',0); % Supp heel
  
  %conh.add(pj(5,2),'>=',0); % Swng Knee
  %conh.add(pj(6,2),'>=',0); % Swng ankle
  conh.add(pj(7,2),'>=',0); % Swng Toe
  conh.add(pj(8,2),'>=',0); % Swng heel
  
  %% 遊脚前進制約
  %conh.add(dpj(6,1),'>=',0);
    if k == K
        conh.add(dpj(2,2),'<=',0); %脚交換制約
        conh.add(pj(4,2),'==',0);  % 支持脚かかと
        % Impact condition is in transition function
    else
        %conh.add(pj(4,2),'>=',0.001);  % 支持脚かかと
    end
  
    if k == 1
      %conh.add(dpj(6,2),'>=',0); %脚交換制約
      q0 = q;
      phi0 = phi;
      dq0 = dq;
      dphi0 = dphi;
    end
  
  ppphi = pphi;
  pphi = phi;
    
  fprintf('gridconstraints3(k=%2d) complete : %.2f seconds\n',k,toc);
end
