%% 立脚期(最初)のgridconstraints

function gridconstraints1(conh, k, K, x, p)
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
  conh.add(pj(4,2),'==',0); % Supp heel
  
  conh.add(pj(5,2),'>=',0); % Swng Knee
  %conh.add(pj(6,2),'>=',0); % Swng ankle
  conh.add(pj(7,2),'>=',0); % Swng Toe
  conh.add(pj(8,2),'>=',0); % Swng heel
 

  %% 支持脚位置固定
  conh.add(pj(2,1),'==',0); % 支持脚
  
  if(k==1)                  % かかとは初期空中
    conh.add(pj(6,2),'>=',0.1);
    conh.add(pj(6,2),'<=',0.3);
    %conh.add(x.th1,'>=',x.th4);
  end
  
  conh.add(dq(8),'>=',0);
  
  %% 遊脚前進制約
  conh.add(dpj(6,1),'>=',0);

    if flags.runtype ~= 0 || k >= 3
      conh.add(ppdlw-2*pdlw+dq(4),'<=',2) %滑らか制約
      conh.add(ppdlw-2*pdlw+dq(4),'>=',-2)
    end

  ppdlw = pdlw;
  pdlw = dq(4);

    if flags.runtype == 0 && k==1
      conh.add(dpj(6,2),'>=',0); %脚交換制約
      q0 = q;
      phi0 = phi;
      dq0 = dq;
      dphi0 = dphi;
    end
        
%   ppphi = pphi;
%   pphi = dq(4);

if flags.runtype ~= 0 || k >= 3
  if flags.use_ankle_sea  
      conh.add(ppphi-2*pphi+phi,'<=',2) %滑らか制約
      conh.add(ppphi-2*pphi+phi,'>=',-2)
  else
      conh.add(ppphi-2*pphi+phi([1,2,4,5]),'<=',2) %滑らか制約
      conh.add(ppphi-2*pphi+phi([1,2,4,5]),'>=',-2)    
  end
end

  ppphi = pphi;
  
  if flags.use_ankle_sea
    pphi = phi;
  else
    pphi = phi([1,2,4,5]);
  end
  
  
  fprintf('gridconstraints1(k=%2d) complete : %.2f seconds\n',k,toc);
end
