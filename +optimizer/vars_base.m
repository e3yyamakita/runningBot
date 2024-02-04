function vars_base(vh)

  global flags alpha v step
  global k_lim
  % State x
  vh.addState('xb');
  vh.addState('yb',  'lb',     0);
  vh.addState('thb', 'lb',  pi/4,'ub',         pi/2); % 腰角度
  if flags.use_wobbling_mass
    vh.addState('lw',  'lb',     0.3*params.l7,'ub',0.7*params.l7); % 揺動質量
  else
    vh.addState('lw',  'lb',     1/2*params.l7,'ub',1/2*params.l7); % 揺動質量
  end

    vh.addState('th1', 'lb',  pi,'ub',     7/4*pi);
    vh.addState('th2', 'lb', -3/4*pi,'ub',            0); % 膝角度
    vh.addState('th3', 'lb',  pi/4,'ub',       3/4*pi); % 足首角度 
    vh.addState('th4', 'lb',  pi,'ub',     7/4*pi);
    vh.addState('th5', 'lb', -3/4*pi,'ub',          0); % 膝角度
    vh.addState('th6', 'lb',  pi/4,'ub',       3/4*pi); % 足首角度


  if flags.use_sea
    vh.addState('phi1');
    vh.addState('phi2');
    vh.addState('phi3');
    vh.addState('phi4');
    vh.addState('phi5');
    vh.addState('phi6');
  else
    vh.addState('phi1', 'lb', 0,'ub', 0);
    vh.addState('phi2', 'lb', 0,'ub', 0);
    vh.addState('phi3', 'lb', 0,'ub', 0);
    vh.addState('phi4', 'lb', 0,'ub', 0);
    vh.addState('phi5', 'lb', 0,'ub', 0);
    vh.addState('phi6', 'lb', 0,'ub', 0);
  end    
  % diff
  vh.addState('dxb');
  vh.addState('dyb');
  vh.addState('dthb');
  if flags.use_wobbling_mass
    vh.addState('dlw');
  else
    vh.addState('dlw',  'lb',     0,'ub',0);
  end
  vh.addState('dth1');
  vh.addState('dth2');
  vh.addState('dth3');
  vh.addState('dth4');
  vh.addState('dth5');
  vh.addState('dth6');
  vh.addState('dphi1', 'lb',-20, 'ub',20);
  vh.addState('dphi2', 'lb',-20, 'ub',20);
  vh.addState('dphi3', 'lb',-20, 'ub',20);
  vh.addState('dphi4', 'lb',-20, 'ub',20);
  vh.addState('dphi5', 'lb',-20, 'ub',20);
  vh.addState('dphi6', 'lb',-20, 'ub',20);
  % time
  vh.addState('time'  ,'lb',0);
  % params
  if flags.optimize_k
    vh.addState('khip'  ,'lb',0, 'ub',k_lim);    %TODO return to ori 1200
    vh.addState('kknee' ,'lb',0, 'ub',k_lim);
    vh.addState('kankle','lb',0, 'ub',k_lim);
  end
  if flags.optimize_mw
    vh.addState('mw'    ,'lb', 0.02, 'ub', 1.5);
  end

  %  Algebraic Variable z
  vh.addAlgVar('ddxb');
  vh.addAlgVar('ddyb');
  vh.addAlgVar('ddthb');
  vh.addAlgVar('ddlw');
  vh.addAlgVar('ddth1');
  vh.addAlgVar('ddth2');
  vh.addAlgVar('ddth3');
  vh.addAlgVar('ddth4');
  vh.addAlgVar('ddth5');
  vh.addAlgVar('ddth6');
  vh.addAlgVar('ddphi1');
  vh.addAlgVar('ddphi2');
  vh.addAlgVar('ddphi3');
  vh.addAlgVar('ddphi4');
  vh.addAlgVar('ddphi5');
  vh.addAlgVar('ddphi6');


  % Control u
%   if flags.optimize_vmode 
    vh.addControl('u1','lb',-500,'ub',500);
    vh.addControl('u2','lb',-500,'ub',500);
    vh.addControl('u3','lb',-500,'ub',500);
    vh.addControl('u4','lb',-500,'ub',500);
    vh.addControl('u5','lb',-500,'ub',500);
    vh.addControl('u6','lb',-500,'ub',500);
    
%     vh.addControl('u1','lb',-100,'ub',100); %TODO Original limit 300,200,100
%     vh.addControl('u2','lb',-80,'ub',80);
%     vh.addControl('u3','lb', -10,'ub', 10);
%     vh.addControl('u4','lb',-100,'ub',100);
%     vh.addControl('u5','lb',-80,'ub',80);
%     vh.addControl('u6','lb', -10,'ub', 10);
%   else
%     vh.addControl('u1','lb',-100,'ub',100);
%     vh.addControl('u2','lb',-80,'ub',80);
%     vh.addControl('u3','lb', -10,'ub', 10);
%     vh.addControl('u4','lb',-100,'ub',100);
%     vh.addControl('u5','lb',-80,'ub',80);
%     vh.addControl('u6','lb', -10,'ub', 10);
    
%     vh.addControl('u1','lb', -80,'ub', 80);
%     vh.addControl('u2','lb', -40,'ub', 40);
%     vh.addControl('u3','lb', -20,'ub', 20);
%     vh.addControl('u4','lb', -80,'ub', 80);
%     vh.addControl('u5','lb', -40,'ub', 40);
%     vh.addControl('u6','lb', -20,'ub', 20);
%   end
  
  if flags.use_wobbling_mass
    vh.addControl('uw','lb',-100,'ub',100);
  else
    vh.addControl('uw','lb',0,'ub',0);
  end
  % Parameter p
  vh.addParameter('alpha', 'default', alpha);
  
  if flags.optimize_vmode
    vh.addState('velocity_achieved','lb',0);
  else
    vh.addParameter('velocity_achieved', 'default', v);
  end

  vh.addState('period','lb',0.5*step/v,'ub',1.5*step/v);
  
end