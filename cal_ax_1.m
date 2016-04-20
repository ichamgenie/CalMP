[VideoName,PathName] = uigetfile('*.avi','选择视频文件');
[tmp,VideoNameLength] = size(VideoName);
Mov = VideoReader(VideoName);
dFrameRate = double(Mov.FrameRate);%视频帧率，即视频每秒帧数
dFrameTime = 1/dFrameRate;%每两帧之间的时间间隔
nFitN = 4;

img_path = [PathName,VideoName(1:VideoNameLength-4)];
t1 = importdata([img_path,'\t.mat']);
xt1 = importdata([img_path,'\xt.mat']);
[sizetmp,numofpt] = size(t1);
t = zeros(1,numofpt-2);
xt = zeros(1,numofpt-2);
vt = zeros(1,numofpt-2);
at = zeros(1,numofpt-2);
for k = 1:numofpt-2
    t(k) = t1(k+1);
    xt(k) = xt1(k+1);
    vt(k) = (xt1(k+2)-xt1(k))/(dFrameTime*2);
    at(k) = (xt1(k+2)-2*xt1(k+1)+xt1(k))/(dFrameTime*dFrameTime);
end
dxmin = min(xt);
dxmax = max(xt);

xt_para = polyfit(t,xt,nFitN);
vt_para = polyfit(t,vt,nFitN);
at_para = polyfit(t,at,nFitN);

ax_para=polyfit(xt,at,nFitN);
vx_para=polyfit(xt,vt,nFitN);
dxstep = (dxmax-dxmin)/40;
xj = dxmin:dxstep:dxmax;
vj = polyval(vx_para,xj);
aj = polyval(ax_para,xj);

save([img_path,'/xj.mat'], 'xj'); 
save([img_path,'/vx_para.mat'], 'vx_para'); 
save([img_path,'/ax_para.mat'], 'ax_para'); 
t_max = max(t);
t_min = min(t);
t_step = (t_max-t_min)/40;
ti=t_min:t_step:t_max;  
xi=polyval(xt_para,ti);  
vi=polyval(vt_para,ti); 
ai=polyval(at_para,ti); 
figure(1);
plot(ti,xi,t,xt,'r.'); 
xlabel('t');ylabel('x');
figure(2);
subplot(2,2,1);
plot(t,vt,t,vt,'r.'); 
xlabel('t');ylabel('v');
subplot(2,2,2);
plot(t,at,t,at,'r.'); 
xlabel('t');ylabel('a');
subplot(2,2,3);
plot(xj,vj,xt,vt,'r.'); 
xlabel('x');ylabel('v');
subplot(2,2,4);
plot(xj,aj,xt,at,'r.'); 
xlabel('x');ylabel('a');