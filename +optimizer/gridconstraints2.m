%% 浮遊期のgridconstraints

function gridconstraints2(conh, k, K, x, p)
tic;
global q0 phi0 dq0 dphi0 pdlw ppdlw step_lb lambda_land
global ppphi pphi v T
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

conh.add(dpj(6,2),'<=',0); %脚交換制約
        
if k == K
    if flags.runtype == 0
        Jc2 = SEA_model.Jc2(params,x);
        dq_after_lambda = [M,-Jc2.'; Jc2,zeros(3,3)] \ [M*dq; zeros(3,1)];
        dq_after = dq_after_lambda(1:10);
        lambda = dq_after_lambda(11:13);
    elseif flags.runtype == 1
        Jtoe2 = SEA_model.Jtoe2(params,x);
        dq_after_lambda = [M,-Jtoe2.'; Jtoe2,zeros(2,2)] \ [M*dq; zeros(2,1)];
        dq_after = dq_after_lambda(1:10);
        lambda = dq_after_lambda(11:12);
    elseif flags.runtype == 2
        Jheel2 = SEA_model.Jheel2(params,x);
        dq_after_lambda = [M,-Jheel2.'; Jheel2,zeros(2,2)] \ [M*dq; zeros(2,1)];
        dq_after = dq_after_lambda(1:10);
        lambda = dq_after_lambda(11:12);
    end
    %conh.add(lambda(1),'<=',lambda(2))
    %conh.add(-lambda(1),'<=',lambda(2)) %TODO make this true
    conh.add(lambda(2),'>=',0)

    swap3x3 = [
        zeros(3),eye(3);
        eye(3),zeros(3)
        ];
    mapDerivWOxb = blkdiag(eye(3),swap3x3,swap3x3); % Reset map one derivative without xb; ie. [yb,zb,thb,th...]
    reset_map = blkdiag(mapDerivWOxb,[1],mapDerivWOxb); % Reset pos without x, but reset vel with x
    conh.add(x.period,'==',x.time);
    
    if flags.optimize_vmode
        conh.add((q(1)-q0(1)),'>=',step_lb); %Minimum step length 
        % Exact loop
        %conh.add([q(2:end);phi;dq_after;dphi],'==',reset_map*[q0(2:end);phi0;dq0;dphi0]);
        %conh.add([q(2:end);phi],'==',reset_map2*[q0(2:end);phi0]);
        
        % Loop acc
        conh.add(norm([q(2:end);phi]-(mapDerivWOxb*[q0(2:end);phi0])),'<=',1e-4);
        conh.add(norm([dq_after;dphi]-[dq0(1);mapDerivWOxb*[dq0(2:end);dphi0]]),'<=',1e-4);
    else
        conh.add((q(1)-q0(1))/x.time,'==',v); %走行速度
        
        % Exact loop
        %conh.add([q(2:end);phi;dq_after;dphi],'==',reset_map*[q0(2:end);phi0;dq0;dphi0]);
        
        % Loop acc
        conh.add(norm([q(2:end);phi]-(mapDerivWOxb*[q0(2:end);phi0])),'<=',1e-4);
        conh.add(norm([dq_after;dphi]-[dq0(1);mapDerivWOxb*[dq0(2:end);dphi0]]),'<=',1e-4);
    end
end
fprintf('gridconstraints2(k=%2d) complete : %.2f seconds\n',k,toc);
end
