function fun_cal_ax2(img_path)
nFitN = 4;
t = importdata([img_path,'\t.mat']);
xt = importdata([img_path,'\xt.mat']);

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

save([img_path,'/xj2.mat'], 'xj'); 
save([img_path,'/vx_para2.mat'], 'vx_para'); 
save([img_path,'/ax_para2.mat'], 'ax_para'); 