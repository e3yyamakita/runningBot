function terminalcost(ch, x, z, u, p)
  tic;
  global v T flags q0
  if flags.optimize_vmode
    ch.add(p.alpha*x.velocity_achieved);
  end
end