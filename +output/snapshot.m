function snapshot(result)

figure;
hold on
axis equal
plot([-1.0 1.5],[0 0],'k')

index = [1:5:sum(result.state_size),sum(result.state_size)];
color = ['r' 'c' 'm' 'g' 'b'];
for i = 1:length(index)
  result.draw_line(index(i), color(mod(i,5)+1));
end

% color = [0.6 0.6 0.6];
% plot(result.xb, result.yb,'Color',color);
% for i = 1:length(index)
%   plot(result.pjx(i,:), result.pjy(i,:),'Color',color);
% end

xlim([-1.0, 1.4]);
ylim([-0.1, 1.4]);

end