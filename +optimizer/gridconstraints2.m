%% 浮遊期のgridconstraints

function gridconstraints2(conh, k, K, x, p)
tic;
global q0 phi0 dq0 dphi0
global ppphi pphi v T
global flags

% 共通部分
[q, dq, phi, dphi] = utils.decompose_state(x);
pj = SEA_model.pj(params,x);
dpj = SEA_model.dpj(params,x);
optimizer.gridconstraints_base(conh, q, phi, pj, dpj, x);

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

M = SEA_model.M(params,x);
Jc1 = SEA_model.Jc1(params,x);
Jc2 = SEA_model.Jc2(params,x);
Jtoe2 = SEA_model.Jtoe2(params,x);
if k == K
    if flags.optimize_vmode
        conh.add(dpj(6,2),'<=',0); %脚交換制約
        %conh.add((q(1)-q0(1))/x.time,'==',dq0(1)); %平均速度指定
        % reset map
        if flags.forefoot
            dq_after_lambda = [M,-Jtoe2.'; Jtoe2,zeros(2,2)] \ [M*dq; zeros(2,1)];
            dq_after = dq_after_lambda(1:10);
        else
            dq_after_lambda = [M,-Jc1.'; Jc1,zeros(3,3)] \ [M*dq; zeros(3,1)];
            dq_after = dq_after_lambda(1:10);
        end
        reset_map1 = [
            zeros(3),eye(3);
            eye(3),zeros(3)
            ];
        reset_map2 = blkdiag(eye(3),reset_map1,reset_map1);
        reset_map = blkdiag(reset_map2,[1],reset_map2);
        T = x.time;
        conh.add([q(2:end);phi;dq_after;dphi],'==',reset_map*[q0(2:end);phi0;dq0;dphi0]);
        %conh.add(norm([q(2:end);phi;dq_after;dphi]-reset_map*[q0(2:end);phi0;dq0;dphi0]),'<=',1e-4);
        % TODO check out if it needs change
    else
        conh.add(dpj(6,2),'<=',0); %脚交換制約
        conh.add((q(1)-q0(1))/x.time,'==',v); %走行速度
        
        % reset map
        if flags.forefoot
            dq_after_lambda = [M,-Jtoe2.'; Jtoe2,zeros(2,2)] \ [M*dq; zeros(2,1)];
            dq_after = dq_after_lambda(1:10);
        else
            dq_after_lambda = [M,-Jc1.'; Jc1,zeros(3,3)] \ [M*dq; zeros(3,1)];
            dq_after = dq_after_lambda(1:10);
        end
        reset_map1 = [
            zeros(3),eye(3);
            eye(3),zeros(3)
            ];
        reset_map2 = blkdiag(eye(3),reset_map1,reset_map1);
        reset_map = blkdiag(reset_map2,[1],reset_map2);
        T = x.time;
        
        
        conh.add([q(2:end);phi;dq_after;dphi],'==',reset_map*[q0(2:end);phi0;dq0;dphi0]);
        
        %conh.add(norm([q(2:end);phi;dq_after;dphi]-reset_map*[q0(2:end);phi0;dq0;dphi0]),'<=',1e-4);
        
    end
end

%滑らか制約
conh.add(ppphi-2*pphi+phi,'<=',2)
conh.add(ppphi-2*pphi+phi,'>=',-2)
ppphi = pphi;
pphi = phi;

fprintf('gridconstraints2(k=%2d) complete : %.2f seconds\n',k,toc);
end
