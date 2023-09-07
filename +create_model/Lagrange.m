function [M]=Lagrange(Lag,x,dx,d2x,d3x)
M = sym('M', size(x));
for i=1:length(x)
    M(i) = create_model.mydiff(diff(Lag,dx(i)), x, dx, d2x, d3x) -  diff(Lag,x(i));
end
M = simplify(M);
end
