function pj(result)

% plot body
figure;
axis([floor((min(min(result.pjx)))*10)/10 ceil((max(max(result.pjx)))*10)/10 ...
    -0.1 ceil((max(max(result.pjy)))*10)/10]);
pbaspect([ceil((max(max(result.pjx)))*10)/10-floor((min(min(result.pjx)))*10)/10 ...
    ceil((max(max(result.pjy)))*10)/10+0.1 ...
    1]);
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