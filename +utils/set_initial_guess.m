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
        
        if(flags.optimize_vmode)
            mode.initialize('dxb'  , [0 1], (ig.xb(end)-ig.xb(1))/sum(ig.period(1:3))*ones(1,2));
        else
            mode.initialize('dxb'  , [0 1], diff(ig.xb(:,n:n+1)  )/period(n)*ones(1,2));
        end
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
        
        if(n>1)
            mode.initialize('ddxb'  , [0 1], diff(diff(ig.xb(:,n-1:n+1)  ))/period(n)*ones(1,2));
            mode.initialize('ddyb'  , [0 1], diff(diff(ig.yb(:,n-1:n+1)  ))/period(n)*ones(1,2));
            mode.initialize('ddthb' , [0 1], diff(diff(ig.thb(:,n-1:n+1) ))/period(n)*ones(1,2));
            mode.initialize('ddlw'  , [0 1], diff(diff(ig.lw(:,n-1:n+1)  ))/period(n)*ones(1,2));
            mode.initialize('ddth1' , [0 1], diff(diff(ig.th1(:,n-1:n+1) ))/period(n)*ones(1,2));
            mode.initialize('ddth2' , [0 1], diff(diff(ig.th2(:,n-1:n+1) ))/period(n)*ones(1,2));
            mode.initialize('ddth3' , [0 1], diff(diff(ig.th3(:,n-1:n+1) ))/period(n)*ones(1,2));
            mode.initialize('ddth4' , [0 1], diff(diff(ig.th4(:,n-1:n+1) ))/period(n)*ones(1,2));
            mode.initialize('ddth5' , [0 1], diff(diff(ig.th5(:,n-1:n+1) ))/period(n)*ones(1,2));
            mode.initialize('ddth6' , [0 1], diff(diff(ig.th6(:,n-1:n+1) ))/period(n)*ones(1,2));
            mode.initialize('ddphi1', [0 1], diff(diff(ig.phi1(:,n-1:n+1)))/period(n)*ones(1,2));
            mode.initialize('ddphi2', [0 1], diff(diff(ig.phi2(:,n-1:n+1)))/period(n)*ones(1,2));
            mode.initialize('ddphi3', [0 1], diff(diff(ig.phi3(:,n-1:n+1)))/period(n)*ones(1,2));
            mode.initialize('ddphi4', [0 1], diff(diff(ig.phi4(:,n-1:n+1)))/period(n)*ones(1,2));
            mode.initialize('ddphi5', [0 1], diff(diff(ig.phi5(:,n-1:n+1)))/period(n)*ones(1,2));
            mode.initialize('ddphi6', [0 1], diff(diff(ig.phi6(:,n-1:n+1)))/period(n)*ones(1,2));
        end
        period_tmp = [0, period];
        mode.initialize('time', [0 1], [sum(period_tmp(1:n)) sum(period_tmp(1:n+1))]);
        
%         mode.initialize('u1' , [0 1], ig.u1(:,n:n+1) );
%         mode.initialize('u2' , [0 1], ig.u2(:,n:n+1) );
%         mode.initialize('u3' , [0 1], ig.u3(:,n:n+1) );
%         mode.initialize('u4' , [0 1], ig.u4(:,n:n+1) );
%         mode.initialize('u5' , [0 1], ig.u5(:,n:n+1) );
%         mode.initialize('u6' , [0 1], ig.u6(:,n:n+1) );
%         mode.initialize('uw' , [0 1], ig.uw(:,n:n+1) );

        if flags.optimize_k
          mode.initialize('khip'  , [0 1],ig.khip  *ones(1,2));
          mode.initialize('kknee' , [0 1],ig.kknee *ones(1,2));
          mode.initialize('kankle', [0 1],ig.kankle*ones(1,2));
        end

        if flags.optimize_mw
          mode.initialize('mw'    , [0 1],ig.mw    *ones(1,2));
        end

        if mode_num <=2
          mode.initialize('fex', [0 1], ig.fex);
          mode.initialize('fey', [0 1], ig.fey);
        end

        if mode_num == 2
          mode.initialize('zmp_x', [0 1], ig.zmp_x);
        end

        if mode_num == 1
            mode.initialize('time', [0 1], [0, ig.period(1)]);
        else
            mode.initialize('time', [0 1], [sum(ig.period(1:mode_num-1)), sum(ig.period(1:mode_num))]);
        end

    end

end