function pathcosts(ch, x, z, u, p)
 % ステージコスト
  tic;
  global v T flags

  if flags.use_sea
    dphi = [x.dphi1;x.dphi2;x.dphi3;x.dphi4;x.dphi5;x.dphi6;x.dlw];
  else
    dth = [x.dth1;x.dth2;x.dth3;x.dth4;x.dth5;x.dth6;x.dlw];
  end

  U = [u.u1;u.u2;u.u3;u.u4;u.u5;u.u6;u.uw];
  if flags.optimize_mw
    M=params.m1 + params.m2 + params.m3 + params.m4 + params.m5 + params.m6 + params.m7 + x.mw;
  else
    M=params.m1 + params.m2 + params.m3 + params.m4 + params.m5 + params.m6 + params.m7 + params.mw;
  end
  g = 9.80665;
  if flags.optimize_vmode
    ch.add(1/x.dxb);
  else
    if flags.use_sea
      ch.add(sum(abs(dphi.*U))/(M*g*v)/T);
    else
      ch.add(sum(abs(dth.*U))/(M*g*v)/T);
    end
  end
  
  fprintf('pathcosts             complete : %.2f seconds\n',toc);
