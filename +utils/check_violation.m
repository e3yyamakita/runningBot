function check_violation(source,sol,periodic_accuracy_bound)
    [q, dq, phi, dphi] = utils.decompose_state(source);
    
    x = utils.compose_state(source,sol{length(source.state_size)}.states{source.state_size(end)});
    M = SEA_model.M(params,x,sol{1}.parameters);
    
    if ismember(source.flags.runtype, [0,7])
        Jc2 = SEA_model.Jc2(params,x);
        dq_after_lambda = [M,-Jc2.'; Jc2,zeros(3,3)] \ [M*dq(:,end); zeros(3,1)];
        dq_after = dq_after_lambda(1:10);
        lambda = dq_after_lambda(11:13);
    elseif ismember(source.flags.runtype, [1,3,5])
        Jtoe2 = SEA_model.Jtoe2(params,x);
        dq_after_lambda = [M,-Jtoe2.'; Jtoe2,zeros(2,2)] \ [M*dq(:,end); zeros(2,1)];
        dq_after = dq_after_lambda(1:10);
        lambda = dq_after_lambda(11:12);
    elseif ismember(source.flags.runtype, [2,4,6])
        Jheel2 = SEA_model.Jheel2(params,x);
        dq_after_lambda = [M,-Jheel2.'; Jheel2,zeros(2,2)] \ [M*dq(:,end); zeros(2,1)];
        dq_after = dq_after_lambda(1:10);
        lambda = dq_after_lambda(11:12);
    end
    
    
    swap3x3 = [
        zeros(3),eye(3);
        eye(3),zeros(3)
        ];
    mapDerivWOxb = blkdiag(eye(3),swap3x3,swap3x3);
    p_viol = ( [q(2:end,end);phi(:,end)] - (mapDerivWOxb* [q(2:end,1);phi(:,1)] ) );
    v_viol = ( [dq_after;dphi(:,end)] - [dq(1,1);mapDerivWOxb* [dq(2:end,1);dphi(:,1)] ] );
    fprintf('Position Periodicity Error: %f \n',norm(p_viol));
    if (norm(p_viol) - periodic_accuracy_bound) > periodic_accuracy_bound*1e-3
        fprintf("\tDecomposed error: %f \n",p_viol);
    end
    fprintf('Velocity Periodicity Error: %f \n',norm(v_viol));
    if (norm(v_viol) - periodic_accuracy_bound) > periodic_accuracy_bound*1e-3
        fprintf("\tDecomposed error: %f \n",v_viol);
    end
    min_time_diff = min(diff(source.time));
    fprintf("Minimum time diff: %f \n",min_time_diff);
end