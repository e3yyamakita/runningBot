function vars3(vh)
  tic;

  global flags

  % 共通部分
  optimizer.vars_base(vh);
  
  % ZMP
  % if flags.use_inerter
  %   vh.addAlgVar('zmp_x','lb', params.l3-params.a3, 'ub', params.l3-params.a3);
  % else

  %end
  vh.addAlgVar('fex');
  vh.addAlgVar('fey', 'lb', 0);
  vh.addAlgVar('feth');%, 'lb', 0, 'ub', 0);


  fprintf('vars3                  complete : %.2f seconds\n',toc);
