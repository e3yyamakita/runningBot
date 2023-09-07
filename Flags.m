classdef Flags
  properties
    use_sea;
    use_wobbling_mass;
    use_inerter;
    optimize_k;
    optimize_mw;
    forefoot;
    bird_leg;
    optimize_vmode;
  end
  methods
    function check(obj)
      if (~obj.use_sea && obj.optimize_k)
        error('SEA flag error');
      end
      if (~obj.use_wobbling_mass && obj.optimize_mw)
        error('mw flag error');
      end
        disp('Flags OK');
    end
  end
end