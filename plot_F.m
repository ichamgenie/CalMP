xj = importdata('D:\matlab\why2\069_2\xj_d.mat');
vd5 = importdata('D:\matlab\why2\069_2\vd_d.mat');
vd6 = importdata('D:\matlab\why2\070_2\vd_d.mat');
vd7 = importdata('D:\matlab\why2\071_2\vd_d.mat');
vd8 = importdata('D:\matlab\why2\072_2\vd_d.mat');
plot(xj,vd5,'r');
hold on;
plot(xj,vd6,'g');
hold on;
plot(xj,vd7,'b');
hold on;
plot(xj,vd8,'m');
hold on;
xlabel('x');ylabel('阻力');
legend('069','070','071','072');   % legend 会自动根据画图顺序分配图形
hold off;