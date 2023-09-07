% x(t),dx(t),d2x(t)の関数y(t)をtで微分したdy/dtをx,dx,d2x,d3xを用いて表現
function dy = mydiff(y, x, dx, d2x, d3x)
  syms t;
  f = sym('f',size(x));

  % diffで微分するために、xやdxをfやdiff(f,t)で置き換え
  for i = 1:length(x)
    f(i) = str2sym(strcat('f',num2str(i),'(t)')); % fi(t)というsymをf(i)に渡す
    % x,dx,d2xを時間の関数のsymであるf(i)に置き換え
    y = subs(y, x(i), f(i));
    y = subs(y, dx(i), diff(f(i),t));
    y = subs(y, d2x(i), diff(diff(f(i),t),t));
  end
  dy = diff(y,t);

  % fやdiff(f,t)をxやdxに戻す
  for i=1:length(x)
    dy = subs(dy, diff(diff(diff(f(i),t),t),t) , d3x(i));
    dy = subs(dy, diff(diff(f(i),t),t), d2x(i));
    dy = subs(dy, diff(f(i),t), dx(i));
    dy = subs(dy, f(i), x(i));
  end
end
