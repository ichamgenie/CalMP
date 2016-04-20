b = importdata('E:\matlab cal new\bx_b.mat');
x = importdata('E:\matlab cal new\bx_x.mat');

plot(x,b,'k-');
hold on;

xlabel('x');ylabel('B');
% legend('71-3','72-1');   % legend 会自动根据画图顺序分配图形
hold off;