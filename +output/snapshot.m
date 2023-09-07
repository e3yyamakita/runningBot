function snapshot(result)

figure;
hold on
axis equal
plot([-1.0 1.5],[0 0],'k')

index = [1 4 result.state_size(1) result.state_size(1)+4 sum(result.state_size)];
color = ['r' 'c' 'm' 'g' 'b'];
for i = 1:length(index)
  result.draw_line(index(i), color(i));
end

color = [0.6 0.6 0.6];
plot(result.xb, result.yb,'Color',color);
for i = [1 2 5 6 9 10]
  plot(result.pjx(i,:), result.pjy(i,:),'Color',color);
end

xlim([-1.0, 1.4]);
ylim([-0.1, 1.4]);

end