clc
clear all 
close 
R = rand(4);
 h = plot(R)
 legend(h, '1', '2', '3', '4')
 hold on
 h2 = plot(mean(R), 'k', 'LineWidth', 2)
 legend([h; h2], '1', '2', '3', '4', 'Total')