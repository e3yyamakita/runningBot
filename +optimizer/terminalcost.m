%function terminalcost(ch, x, p)
function terminalcost(ch, x, p)
  tic;
  global v flags q0
  if flags.optimize_vmode
    %ch.add(500*p.alpha*x.velocity_achieved);
  end
end