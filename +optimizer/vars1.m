function vars1(vh)
  tic;

  global flags

  % 共通部分
  optimizer.vars_base(vh);
  
  % ZMP
  vh.addAlgVar('zmp_x','lb', -params.a3, 'ub', params.l3-params.a3);
  %end
  
  
  vh.addAlgVar('fex', 'lb', -1, 'ub', 1);
  vh.addAlgVar('fey', 'lb', 0);
  vh.addAlgVar('feth', 'lb', -params.c1, 'ub', params.l3-params.c1);
  fprintf('vars1                  complete : %.2f seconds\n',toc);
