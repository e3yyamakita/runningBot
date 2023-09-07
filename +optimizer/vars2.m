function vars2(vh)
  tic;

  % 共通部分
  optimizer.vars_base(vh);
  
  
  % ZMP
  % 浮遊期なので無し  
  vh.addAlgVar('fex', 'lb', 0, 'ub', 0);
  vh.addAlgVar('fey', 'lb', 0, 'ub', 0);
  vh.addAlgVar('feth', 'lb', 0, 'ub', 0);


  fprintf('vars2                  complete : %.2f seconds\n',toc);
