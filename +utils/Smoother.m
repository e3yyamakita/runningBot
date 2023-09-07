classdef Smoother
  properties (Hidden)
    x
    px % pre_x
    ppx % pre_pre_x
  end
  methods
    function obj = update(obj, x)
      obj.ppx = obj.px;
      obj.px = obj.x;
      obj.x = x;
    end
    function v = get_eval_value(obj)
      v = obj.ppx-2*obj.px+obj.x;
    end
  end
end