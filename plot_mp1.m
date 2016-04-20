[VideoName,PathName] = uigetfile('*.avi','选择视频文件');
[tmp,VideoNameLength] = size(VideoName);
img_path = [PathName,VideoName(1:VideoNameLength-4)];

cal_method = 2;%1表示用离散的方法计算v、a；2表示用多项式求导的方法计算v、a

flag = num2str(cal_method);
xj = importdata([img_path,'\xj',flag,'.mat']);
MP = importdata([img_path,'\mp',flag,'.mat']);
vx_para1 = importdata([img_path,'\vx_para',flag,'.mat']);
ax_para1 = importdata([img_path,'\ax_para',flag,'.mat']);
vx1 = polyval(vx_para1,xj);
ax1 = polyval(ax_para1,xj);
figure(1);
plot(xj,MP);
xlabel('x');ylabel('MP');
figure(2);
plot(xj,ax1);
figure(3);
plot(xj,vx1);