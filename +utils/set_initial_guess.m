function set_initial_guess(mode, mode_num, ig, period)
global flags

n = mode_num;
if true
mode.initialize('xb'  , [0 1], ig.xb(:,n:n+1)  );
mode.initialize('yb'  , [0 1], ig.yb(:,n:n+1)  );
mode.initialize('thb' , [0 1], ig.thb(:,n:n+1) );
mode.initialize('lw'  , [0 1], ig.lw(:,n:n+1)  );
mode.initialize('th1' , [0 1], ig.th1(:,n:n+1) );
mode.initialize('th2' , [0 1], ig.th2(:,n:n+1) );
mode.initialize('th3' , [0 1], ig.th3(:,n:n+1) );
mode.initialize('th4' , [0 1], ig.th4(:,n:n+1) );
mode.initialize('th5' , [0 1], ig.th5(:,n:n+1) );
mode.initialize('th6' , [0 1], ig.th6(:,n:n+1) );
mode.initialize('phi1', [0 1], ig.phi1(:,n:n+1));
mode.initialize('phi2', [0 1], ig.phi2(:,n:n+1));
mode.initialize('phi3', [0 1], ig.phi3(:,n:n+1));
mode.initialize('phi4', [0 1], ig.phi4(:,n:n+1));
mode.initialize('phi5', [0 1], ig.phi5(:,n:n+1));
mode.initialize('phi6', [0 1], ig.phi6(:,n:n+1));
mode.initialize('dxb'  , [0 1], diff(ig.xb(:,n:n+1)  )/period(n)*ones(1,2));
mode.initialize('dyb'  , [0 1], diff(ig.yb(:,n:n+1)  )/period(n)*ones(1,2));
mode.initialize('dthb' , [0 1], diff(ig.thb(:,n:n+1) )/period(n)*ones(1,2));
mode.initialize('dlw'  , [0 1], diff(ig.lw(:,n:n+1)  )/period(n)*ones(1,2));
mode.initialize('dth1' , [0 1], diff(ig.th1(:,n:n+1) )/period(n)*ones(1,2));
mode.initialize('dth2' , [0 1], diff(ig.th2(:,n:n+1) )/period(n)*ones(1,2));
mode.initialize('dth3' , [0 1], diff(ig.th3(:,n:n+1) )/period(n)*ones(1,2));
mode.initialize('dth4' , [0 1], diff(ig.th4(:,n:n+1) )/period(n)*ones(1,2));
mode.initialize('dth5' , [0 1], diff(ig.th5(:,n:n+1) )/period(n)*ones(1,2));
mode.initialize('dth6' , [0 1], diff(ig.th6(:,n:n+1) )/period(n)*ones(1,2));
mode.initialize('dphi1', [0 1], diff(ig.phi1(:,n:n+1))/period(n)*ones(1,2));
mode.initialize('dphi2', [0 1], diff(ig.phi2(:,n:n+1))/period(n)*ones(1,2));
mode.initialize('dphi3', [0 1], diff(ig.phi3(:,n:n+1))/period(n)*ones(1,2));
mode.initialize('dphi4', [0 1], diff(ig.phi4(:,n:n+1))/period(n)*ones(1,2));
mode.initialize('dphi5', [0 1], diff(ig.phi5(:,n:n+1))/period(n)*ones(1,2));
mode.initialize('dphi6', [0 1], diff(ig.phi6(:,n:n+1))/period(n)*ones(1,2));
period_tmp = [0, period];
mode.initialize('time', [0 1], [sum(period_tmp(1:n)) sum(period_tmp(1:n+1))]);

if flags.optimize_k
  mode.initialize('khip'  , [0 1],ig.khip  *ones(1,2));
  mode.initialize('kknee' , [0 1],ig.kknee *ones(1,2));
  mode.initialize('kankle', [0 1],ig.kankle*ones(1,2));
end
if flags.optimize_mw
  mode.initialize('mw'    , [0 1],ig.mw    *ones(1,2));
end
if mode_num == 1
  mode.initialize('zmp_x', [0 1], ig.zmp_x);
  mode.initialize('fex', [0 1], ig.fex);
  mode.initialize('fey', [0 1], ig.fey);
end

else
  
end

end