%% Forefootのgridconstraints

function gridconstraints3(conh, k, K, x, p)
  tic;
  global q0 phi0 dq0 dphi0 ppdlw pdlw
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
if ~(k==K) 
  conh.add(pj(3,2),'>=',0); % Supp Toe
end

  conh.add(pj(4,2),'==',0); % Supp heel

  
  conh.add(pj(5,2),'>=',0); % Swng Knee
  %conh.add(pj(6,2),'>=',0); % Swng ankle
  conh.add(pj(7,2),'>=',0); % Swng Toe
  conh.add(pj(8,2),'>=',0); % Swng heel
  
  conh.add(dpj(6,1),'>=',0);
  
  conh.add(dq(8),'>=',0);
  
  %% 遊脚前進制約
    if k == 1
        conh.add(pj(4,2),'>=',0);  % 支持脚かかと
        conh.add(dpj(6,2),'>=',0); %脚交換制約
        q0 = q;
        phi0 = phi;
        dq0 = dq;
        dphi0 = dphi;
    elseif k == K
        M = SEA_model.M(params,x,p);
        Jc1 = SEA_model.Jc1(params,x);
        %conh.add(dpj(2,2),'<=',0); %脚交換制約
        %conh.add(pj(4,2),'==',0);  % 支持脚かかと
        dq_after_lambda = [M,-Jc1.'; Jc1,zeros(3,3)] \ [M*dq; zeros(3,1)];
        lambda = dq_after_lambda(11:end);
        conh.add(lambda(1),'<=',lambda(2));
        conh.add(-lambda(1),'<=',lambda(2));
        conh.add(lambda(2),'>=',0);
        % Impact condition is in transition function
    end
 
  ppphi = pphi;
  if flags.use_ankle_sea
    pphi = phi;
  else
    pphi = phi([1,2,4,5]);
  end
    
  ppdlw = pdlw;
  pdlw = dq(4);
  fprintf('gridconstraints3(k=%2d) complete : %.2f seconds\n',k,toc);
end
