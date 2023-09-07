function pj(result)

% plot body
figure;
hold on
plot(result.xb, result.yb);
for i=1:height(result.pjx)
  plot(result.pjx(i,:), result.pjy(i,:));
end

len = length(result.pjx);
for k=1:len/5:len
  result.draw_line(int32(k), [0.6 0.3 0]);
end
result.draw_line(len, [0.6 0.3 0]);

end