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
conh.add(pj(1,2),'>=',0);
conh.add(pj(2,2),'>=',0);
conh.add(pj(3,2),'>=',0);
conh.add(pj(4,2),'>=',0);
conh.add(pj(5,2),'>=',0);
conh.add(pj(7,2),'>=',0);
conh.add(pj(8,2),'>=',0);

% 遊脚前進制約
conh.add(dpj(2,1),'>=',0);
conh.add(dpj(6,1),'>=',0);

M = SEA_model.M(params,x);
Jc2 = SEA_model.Jc2(params,x);
if k == K
    if flags.optimize_vmode
        conh.add(dpj(6,2),'<=',0); %脚交換制約
        % conh.add((q(1)-q0(1))/x.time,'==',dq0(1)); %平均速度指定
        % reset map
        dq_after_lambda = [M,-Jc2.'; Jc2,zeros(3,3)] \ [M*dq; zeros(3,1)];
        dq_after = dq_after_lambda(1:10);
        reset_map1 = [
            zeros(3),eye(3);
            eye(3),zeros(3)
            ];
        reset_map2 = blkdiag(eye(4),reset_map1,reset_map1);
        reset_map = blkdiag(reset_map2,reset_map2);
        T = x.time;
        conh.add([q;phi;dq_after;dphi],'==',reset_map*[q0;phi0;dq0;dphi0]+[T*dq0(1);zeros(31,1)]);
    else
        conh.add(dpj(6,2),'<=',0); %脚交換制約
        conh.add((q(1)-q0(1))/x.time,'==',v); %走行速度
        % reset map
        dq_after_lambda = [M,-Jc2.'; Jc2,zeros(3,3)] \ [M*dq; zeros(3,1)];
        dq_after = dq_after_lambda(1:10);
        reset_map1 = [
            zeros(3),eye(3);
            eye(3),zeros(3)
            ];
        reset_map2 = blkdiag(eye(4),reset_map1,reset_map1);
        reset_map = blkdiag(reset_map2,reset_map2);
        T = x.time;
        conh.add([q;phi;dq_after;dphi],'==',reset_map*[q0;phi0;dq0;dphi0]+[T*v;zeros(31,1)]);
    end
end
%TODO fix final state constraint, need to move this to the last slot

% 滑らか制約
conh.add(ppphi-2*pphi+phi,'<=',2)
conh.add(ppphi-2*pphi+phi,'>=',-2)
ppphi = pphi;
pphi = phi;

fprintf('gridconstraints2(k=%2d) complete : %.2f seconds\n',k,toc);
end
