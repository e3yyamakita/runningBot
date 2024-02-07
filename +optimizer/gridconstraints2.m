%% 浮遊期のgridconstraints

function gridconstraints2(conh, k, K, x, p)
tic;
global q0 phi0 dq0 dphi0 pdlw ppdlw lambda_land periodic_accuracy_bound step_lb
global ppphi pphi
global flags

% 共通部分
[q, dq, phi, dphi] = utils.decompose_state(x);
pj = SEA_model.pj(params,x);
dpj = SEA_model.dpj(params,x);
optimizer.gridconstraints_base(conh, q, phi, pj, dpj, x, p);

% 各関節が地面より上(y座標制約)
  conh.add(pj(1,2),'>=',0); % Supp Knee
  %conh.add(pj(2,2),'>=',0); % Supp ankle
  conh.add(pj(3,2),'>=',0); % Supp Toe
  conh.add(pj(4,2),'>=',0); % Supp heel
  
  conh.add(pj(5,2),'>=',0); % Swng Knee
  %conh.add(pj(6,2),'>=',0); % Swng ankle
  conh.add(pj(7,2),'>=',0); % Swng Toe
  conh.add(pj(8,2),'>=',0); % Swng heel

% 遊脚前進制約
conh.add(dpj(2,1),'>=',0);
conh.add(dpj(6,1),'>=',0);

M = SEA_model.M(params,x,p);


        
if k == K
    conh.add(dpj(6,2),'<=',0); %脚交換制約
    if flags.runtype == 0
        Jc2 = SEA_model.Jc2(params,x);
        dq_after_lambda = [M,-Jc2.'; Jc2,zeros(3,3)] \ [M*dq; zeros(3,1)];
        dq_after = dq_after_lambda(1:10);
        lambda = dq_after_lambda(11:13);
        conh.add(Jc2*dq_after,'==',0);
                 conh.add(lambda(3),'<=',0.075*lambda(2));
         conh.add(-lambda(3),'<=',0.025*lambda(2));
    elseif ismember(flags.runtype, [1,3,5])
        Jtoe2 = SEA_model.Jtoe2(params,x);
        dq_after_lambda = [M,-Jtoe2.'; Jtoe2,zeros(2,2)] \ [M*dq; zeros(2,1)];
        dq_after = dq_after_lambda(1:10);
        lambda = dq_after_lambda(11:12);
        conh.add(Jtoe2*dq_after,'==',0);
    elseif ismember(flags.runtype, [2,4,6])
        Jheel2 = SEA_model.Jheel2(params,x);
        dq_after_lambda = [M,-Jheel2.'; Jheel2,zeros(2,2)] \ [M*dq; zeros(2,1)];
        dq_after = dq_after_lambda(1:10);
        lambda = dq_after_lambda(11:12);
        conh.add(Jheel2*dq_after,'==',0);
    end
     conh.add(lambda(1),'<=',lambda(2))
     conh.add(-lambda(1),'<=',lambda(2)) %TODO make this true
    conh.add(lambda(2),'>=',0)

    swap3x3 = [
        zeros(3),eye(3);
        eye(3),zeros(3)
        ];
    mapDerivWOxb = blkdiag(eye(3),swap3x3,swap3x3); % Reset map one derivative without xb; ie. [yb,zb,thb,th...]
    reset_map = blkdiag(mapDerivWOxb,[1],mapDerivWOxb); % Reset pos without x, but reset vel with x
    conh.add(x.period,'==',x.time);

    % Loop acc
    conh.add(norm([q(2:end);phi]-(mapDerivWOxb*[q0(2:end);phi0])),'<=',periodic_accuracy_bound);
    conh.add(norm([dq_after;dphi]-[dq0(1);mapDerivWOxb*[dq0(2:end);dphi0]]),'<=',periodic_accuracy_bound);
    
    if flags.optimize_vmode
        conh.add((q(1)-q0(1)),'>=',step_lb);
        conh.add((q(1)-q0(1)/x.period),'==',x.velocity_achieved);
    else
        conh.add((q(1)-q0(1))/x.period,'==',p.velocity_achieved); %走行速度
    end
    
end

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
    
fprintf('gridconstraints2(k=%2d) complete : %.2f seconds\n',k,toc);
end
