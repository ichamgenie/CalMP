[VideoName,PathName] = uigetfile('*.avi','选择视频文件');
[tmp,VideoNameLength] = size(VideoName);
img_path = [PathName,VideoName(1:VideoNameLength-4)];

cal_method = 2;%1表示用离散的方法计算v、a；2表示用多项式求导的方法计算v、a

flag = num2str(cal_method);
xj_path = [img_path,'\xj',flag,'.mat'];
mp_path = [img_path,'\mp',flag,'.mat'];
vx_path = [img_path,'\vx_para',flag,'.mat'];
ax_path = [img_path,'\ax_para',flag,'.mat'];
xj = importdata(xj_path);
MP = importdata(mp_path);
vx_para1 = importdata(vx_path);
ax_para1 = importdata(ax_path);
vx1 = polyval(vx_para1,xj);
ax1 = polyval(ax_para1,xj);

idxmin = 10;
idxmax = 40;
xj4draw = xj(idxmin:idxmax);
mp4draw = MP(idxmin:idxmax);

max_y = max(MP);
max_x = xj(round(find(MP==max_y)));

figure(1);
plot(xj,MP);
xlabel('x');ylabel('MP');
figure(2);
plot(xj,ax1);
figure(3);
plot(xj,vx1);
set(gca,'color',[0,0,0]);