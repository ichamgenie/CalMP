[VideoName,PathName] = uigetfile('*.avi','选择视频文件');
[tmp,VideoNameLength] = size(VideoName);
img_path = [PathName,VideoName(1:VideoNameLength-4)];
t = importdata([img_path,'\t.mat']);
xt = importdata([img_path,'\xt.mat']);

[sizetmp,numofpt] = size(t);

dxmin = min(xt);
dxmax = max(xt);

xt_para = polyfit(t,xt,nFitN);
vt_para = zeros(1,nFitN);
at_para = zeros(1,nFitN-1);

for k = 1:nFitN
    vt_para(k) = xt_para(k)*(nFitN-k+1);
end
for k = 1:nFitN-1
    at_para(k) = vt_para(k)*(nFitN-k);
end
vt=polyval(vt_para,t); 
at=polyval(at_para,t); 

ax_para=polyfit(xt,at,nFitN);
vx_para=polyfit(xt,vt,nFitN);
dxstep = (dxmax-dxmin)/40;
xj = dxmin:dxstep:dxmax;
vj = polyval(vx_para,xj);
aj = polyval(ax_para,xj);

b = importdata('E:\matlab cal new\bx_b.mat');
x = importdata('E:\matlab cal new\bx_x.mat');
bx_para = importdata('E:\matlab cal new\bx_para.mat');
dbx_para = polyder(bx_para);
dbx = polyval(dbx_para,x)
b = b/5000;
dbx = dbx/5000000;

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

figure(3);
plot(x,b,'k-');
hold on;
plot(x,dbx,'k--');
hold on;
plot(xj,aj,'r'); 
hold on;
plot(xj,vj,'r--');