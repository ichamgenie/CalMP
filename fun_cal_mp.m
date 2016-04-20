function fun_cal_mp(a,img_path,drop_vol)
flag = num2str(a);
name1 = [img_path,'\vx_para',flag,'.mat'];
vx_para1 = importdata([img_path,'\vx_para',flag,'.mat']);%读取vx（速度-位置曲线的多项式系数）
ax_para1 = importdata([img_path,'\ax_para',flag,'.mat']);%读取ax（加速度-位置曲线的多项式系数）
bx_para = importdata('bx_para.mat');
vol = drop_vol/1000000;%小球体积，单位L
% dEta = 0.008;%石蜡和二氯甲烷混合(0.0589);%粘滞系数
dEta = 0.0008; %水
dp = ((6*(vol/1000)/3.1416)^(1/3));%小球直径，单位米
midu1 = 0.93;%液体密度，单位kg/L
midushui = 1;%水密度，单位kg/L
F = 0;%(midushui-midu1)*vol*9.8;%浮力

xj = importdata([img_path,'\xj',flag,'.mat']);
Bx = polyval(bx_para,xj); %polyval()函数用来从bx_para（多项式系数）计算得到多项式函数的曲线，同时
% Bx=(-9.697*4E4).*xj.^3+3*3793.*xj.^2-29.79*2.*xj+0.5334;
vx1 = polyval(vx_para1,xj);
ax1 = polyval(ax_para1,xj);
Fgx = vol.*ax1+(3*pi*dEta*dp).*vx1;
ma2 = vol*1.*ax1;
vd2=(3*pi*dEta*dp).*vx1;
MP = (ma2+vd2+F)./Bx;
save([img_path,'\mp',flag,'.mat'], 'MP'); 
save([img_path,'\vd',flag,'.mat'], 'vd2'); 
save([img_path,'\bx',flag,'.mat'], 'Bx'); 
