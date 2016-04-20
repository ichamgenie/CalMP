mp5 = importdata('D:\matlab\why2\069_2\mp_d.mat');
mp6 = importdata('D:\matlab\why2\070_2\mp_d.mat');
mp7 = importdata('D:\matlab\why2\071_2\mp_d.mat');
mp8 = importdata('D:\matlab\why2\072_2\mp_d.mat');
vd5 = importdata('D:\matlab\why2\069_2\vd_d.mat');
vd6 = importdata('D:\matlab\why2\070_2\vd_d.mat');
vd7 = importdata('D:\matlab\why2\071_2\vd_d.mat');
vd8 = importdata('D:\matlab\why2\072_2\vd_d.mat');
plot(vd5,mp5,'r');
hold on;
plot(vd6,mp6,'g');
hold on;
plot(vd7,mp7,'b');
hold on;
plot(vd8,mp8,'m');
hold on;
xlabel('阻力');ylabel('MP');
legend('069','070','071','072');   % legend 会自动根据画图顺序分配图形
hold off;