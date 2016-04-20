function fun_cal_ax1(img_path,dFrameTime)
nFitN = 4;
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
dxstep = (dxmax-dxmin)/40;
xj = dxmin:dxstep:dxmax;

ax_para=polyfit(xt,at,nFitN);
vx_para=polyfit(xt,vt,nFitN);

save([img_path,'/xj1.mat'], 'xj'); 
save([img_path,'/vx_para1.mat'], 'vx_para'); 
save([img_path,'/ax_para1.mat'], 'ax_para'); 