function x = compose_state(source,sol)
    x.xb = sol.xb.value;
    x.yb  = sol.yb.value;
    x.thb = sol.thb.value;
    x.lw  = sol.lw.value;
    x.th1  = sol.th1.value;
    x.th2  = sol.th2.value;
    x.th3  = sol.th3.value;
    x.th4  = sol.th4.value;
    x.th5  = sol.th5.value;
    x.th6  = sol.th6.value;

    x.dxb  = sol.dxb.value;
    x.dyb  = sol.dyb.value;
    x.dthb  = sol.dthb.value;
    x.dlw  = sol.dlw.value;
    x.dth1  = sol.dth1.value;
    x.dth2  = sol.dth2.value;
    x.dth3  = sol.dth3.value;
    x.dth4  = sol.dth4.value;
    x.dth5  = sol.dth5.value;
    x.dth6  = sol.dth6.value;

    x.phi1  = sol.phi1.value;
    x.phi2  = sol.phi2.value;
    x.phi3  = sol.phi3.value;
    x.phi4  = sol.phi4.value;
    x.phi5  = sol.phi5.value;
    x.phi6  = sol.phi6.value;

    x.dphi1  = sol.dphi1.value;
    x.dphi2  = sol.dphi2.value;
    x.dphi3  = sol.dphi3.value;
    x.dphi4  = sol.dphi4.value;
    x.dphi5  = sol.dphi5.value;
    x.dphi6  = sol.dphi6.value;
    
    if source.flags.optimize_mw
        x.mw   = sol.mw.value;
    end
end