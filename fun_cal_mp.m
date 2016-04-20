function fun_cal_mp(a,img_path,drop_vol)
flag = num2str(a);
name1 = [img_path,'\vx_para',flag,'.mat'];
vx_para1 = importdata([img_path,'\vx_para',flag,'.mat']);%��ȡvx���ٶ�-λ�����ߵĶ���ʽϵ����
ax_para1 = importdata([img_path,'\ax_para',flag,'.mat']);%��ȡax�����ٶ�-λ�����ߵĶ���ʽϵ����
bx_para = importdata('bx_para.mat');
vol = drop_vol/1000000;%С���������λL
% dEta = 0.008;%ʯ���Ͷ��ȼ�����(0.0589);%ճ��ϵ��
dEta = 0.0008; %ˮ
dp = ((6*(vol/1000)/3.1416)^(1/3));%С��ֱ������λ��
midu1 = 0.93;%Һ���ܶȣ���λkg/L
midushui = 1;%ˮ�ܶȣ���λkg/L
F = 0;%(midushui-midu1)*vol*9.8;%����

xj = importdata([img_path,'\xj',flag,'.mat']);
Bx = polyval(bx_para,xj); %polyval()����������bx_para������ʽϵ��������õ�����ʽ���������ߣ�ͬʱ
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
