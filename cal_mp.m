[VideoName,PathName] = uigetfile('*.avi','选择视频文件');
[tmp,VideoNameLength] = size(VideoName);
img_path = [PathName,VideoName(1:VideoNameLength-4)];
vx_para1 = importdata([img_path,'\vx_para2.mat']);%读取vx（速度-位置曲线的多项式系数）
ax_para1 = importdata([img_path,'\ax_para2.mat']);%读取ax（加速度-位置曲线的多项式系数）
bx_para = importdata('bx_para.mat');
vol = (2.0E-6);%小球体积，单位L
dEta = (0.0589);%粘滞系数
dp = ((6*(vol/1000)/3.1416)^(1/3));%小球直径，单位米
midu1 = 0.93;%液体密度，单位kg/L
midushui = 1;%水密度，单位kg/L
F = (midushui-midu1)*vol*9.8;%浮力

xj = importdata([img_path,'\xj2.mat']);
Bx = polyval(bx_para,xj); %polyval()函数用来从bx_para（多项式系数）计算得到多项式函数的曲线，同时
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