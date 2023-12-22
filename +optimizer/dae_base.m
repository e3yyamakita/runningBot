function dae_base(daeh, x, z, u, p)

  global flags

  daeh.setODE('xb'    , x.dxb   );
  daeh.setODE('yb'    , x.dyb   );
  daeh.setODE('thb'   , x.dthb  );
  if flags.use_wobbling_mass
    daeh.setODE('lw'    , x.dlw   );
  else
    daeh.setODE('lw'    , 0);
  end
  daeh.setODE('th1'   , x.dth1  );
  daeh.setODE('th2'   , x.dth2  );
  daeh.setODE('th3'   , x.dth3  );
  daeh.setODE('th4'   , x.dth4  );
  daeh.setODE('th5'   , x.dth5  );
  daeh.setODE('th6'   , x.dth6  );
  daeh.setODE('phi1'  , x.dphi1 );
  daeh.setODE('phi2'  , x.dphi2 );
  daeh.setODE('phi4'  , x.dphi4 );
  daeh.setODE('phi5'  , x.dphi5 );
  if flags.use_ankle_sea
    daeh.setODE('phi3'  , x.dphi3 );
    daeh.setODE('phi6'  , x.dphi6 );
  else
    daeh.setODE('phi3'  , 0 );
    daeh.setODE('phi6'  , 0 );      
  end
  daeh.setODE('dxb'   , z.ddxb  );
  daeh.setODE('dyb'   , z.ddyb  );
  daeh.setODE('dthb'  , z.ddthb );
  if flags.use_wobbling_mass
    daeh.setODE('dlw'   , z.ddlw  );
  else
    daeh.setODE('dlw'   , 0);
  end
  daeh.setODE('dth1'  , z.ddth1 );
  daeh.setODE('dth2'  , z.ddth2 );
  daeh.setODE('dth3'  , z.ddth3 );
  daeh.setODE('dth4'  , z.ddth4 );
  daeh.setODE('dth5'  , z.ddth5 );
  daeh.setODE('dth6'  , z.ddth6 );
  daeh.setODE('dphi1' , z.ddphi1);
  daeh.setODE('dphi2' , z.ddphi2);
  daeh.setODE('dphi4' , z.ddphi4);
  daeh.setODE('dphi5' , z.ddphi5);
  if flags.use_ankle_sea
    daeh.setODE('dphi3'  , z.ddphi3 );
    daeh.setODE('dphi6'  , z.ddphi6 );
  else
    daeh.setODE('dphi3'  , 0 );
    daeh.setODE('dphi6'  , 0 );      
  end
  
  daeh.setODE('time'  , 1       );
  
  if flags.optimize_k
    daeh.setODE('khip'  , 0);
    daeh.setODE('kknee'  , 0);
    daeh.setODE('kankle'  , 0);
  end
  
  if flags.optimize_mw
    daeh.setODE('mw'    , 0);
  end
  
  daeh.setODE('period', 0);
end