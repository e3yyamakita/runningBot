function pathcosts(ch, x, z, u, p)
 % ステージコスト
  tic;
  global v flags alpha q0 cost_scaling

  if flags.use_ankle_sea
    actuator_vel = [x.dphi1;x.dphi2;x.dphi3;x.dphi4;x.dphi5;x.dphi6];
    if flags.use_wobbling_mass
        actuator_vel = [actuator_vel;x.dlw];
    end
  else
    actuator_vel = [x.dphi1;x.dphi2;x.dth3;x.dphi4;x.dphi5;x.dth6];
    if flags.use_wobbling_mass
        actuator_vel = [actuator_vel;x.dlw];
    end
  end
  
  
  
  U = [u.u1;u.u2;u.u3;u.u4;u.u5;u.u6];
  if flags.use_wobbling_mass
        U = [U;u.uw];
  end
  
  if flags.optimize_mw
    M=params.m1 + params.m2 + params.m3 + params.m4 + params.m5 + params.m6 + params.m7 + x.mw;
  else
    M=params.m1 + params.m2 + params.m3 + params.m4 + params.m5 + params.m6 + params.m7 + params.mw;
  end
  
  g = 9.80665;

  if flags.optimize_vmode
    ch.add(alpha * cost_scaling/(x.dxb)/x.period + (1-alpha)* cost_scaling * sum(abs(actuator_vel.*U))/(M*g*x.velocity_achieved)/x.period);
    %ch.add((1-alpha)*sum(abs(actuator_vel.*U))/(M*g*x.velocity_achieved)/x.period);
  else
    ch.add(cost_scaling*sum(abs(actuator_vel.*U))/(M*g*p.velocity_achieved)/x.period);
  end
  
  fprintf('pathcosts             complete : %.2f seconds\n',toc);
