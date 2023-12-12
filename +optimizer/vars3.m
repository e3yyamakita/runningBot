function vars3(vh)
  tic;

  global flags

  % 共通部分
  optimizer.vars_base(vh);
  
  vh.addAlgVar('feth', 'lb', 0, 'ub', 0);
  vh.addAlgVar('fex', 'lb', -1, 'ub', 1);
  vh.addAlgVar('fey', 'lb', 0);
  
  
  fprintf('vars3                  complete : %.2f seconds\n',toc);
