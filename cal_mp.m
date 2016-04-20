[VideoName,PathName] = uigetfile('*.avi','ѡ����Ƶ�ļ�');
[tmp,VideoNameLength] = size(VideoName);
img_path = [PathName,VideoName(1:VideoNameLength-4)];
vx_para1 = importdata([img_path,'\vx_para2.mat']);%��ȡvx���ٶ�-λ�����ߵĶ���ʽϵ����
ax_para1 = importdata([img_path,'\ax_para2.mat']);%��ȡax�����ٶ�-λ�����ߵĶ���ʽϵ����
bx_para = importdata('bx_para.mat');
vol = (2.0E-6);%С���������λL
dEta = (0.0589);%ճ��ϵ��
dp = ((6*(vol/1000)/3.1416)^(1/3));%С��ֱ������λ��
midu1 = 0.93;%Һ���ܶȣ���λkg/L
midushui = 1;%ˮ�ܶȣ���λkg/L
F = (midushui-midu1)*vol*9.8;%����

xj = importdata([img_path,'\xj2.mat']);
Bx = polyval(bx_para,xj); %polyval()����������bx_para������ʽϵ��������õ�����ʽ���������ߣ�ͬʱ
% Bx=(-9.697*4E4).*xj.^3+3*3793.*xj.^2-29.79*2.*xj+0.5334;
vx1 = polyval(vx_para1,xj);
ax1 = polyval(ax_para1,xj);
Fgx = vol.*ax1+(3*pi*dEta*dp).*vx1;
ma2 = vol.*ax1;
vd2=(3*pi*dEta*dp).*vx1;
MP = (ma2+vd2+F)./Bx;
save([img_path,'\mp.mat'], 'MP'); 
save([img_path,'\vd.mat'], 'vd2'); 
save([img_path,'\bx.mat'], 'Bx'); 
%save([img_path,'\xj.mat'], 'xj'); 
figure(1);
plot(xj,MP);
xlabel('x');ylabel('MP');
% figure(2);
% plot(xj,ax1);
% figure(3);
% plot(xj,vx1);
% figure(4);
% plot(xj,Bx);