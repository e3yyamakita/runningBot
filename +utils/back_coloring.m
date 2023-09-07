function back_coloring(x_range, color)
hold on;

xlimit = get(gca, 'XLim');
ylimit = get(gca, 'YLim');

if x_range(2) == inf
  x_range(2) = xlimit(2);
end
if x_range(1) == -inf
  x_range(1) = xlimit(1);
end

upper = [ylimit(2) ylimit(2)];
lower = ylimit(1);
area_handle = area(x_range, upper, lower);
hold off;

set(area_handle,'FaceColor', color);                                        % 塗りつぶし色
set(area_handle,'FaceAlpha', 0.1);                                        % 塗りつぶし透明度
set(area_handle,'LineStyle','none');                                        % 塗りつぶし部分に枠を描かない
set(area_handle,'ShowBaseline','off');                                      % ベースラインの不可視化
set(gca,'layer','top');                                                     % gridを塗りつぶしの前面に出す
set(area_handle.Annotation.LegendInformation, 'IconDisplayStyle','off');    % legendに入れないようにする
children_handle = get(gca, 'Children');                                     % Axisオブジェクトの子オブジェクトを取得
set(gca, 'Children', circshift(children_handle,[-1 0]));                    % 子オブジェクトの順番変更

set(gca,'Xlim',xlimit);							    % 表示の調整
set(gca,'Ylim',ylimit);
end