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
xlabel('x');ylabel('����');
legend('069','070','071','072');   % legend ���Զ����ݻ�ͼ˳�����ͼ��
hold off;