[VideoName,PathName] = uigetfile('*.avi','选择视频文件');
[tmp,VideoNameLength] = size(VideoName);
img_path = [PathName,VideoName(1:VideoNameLength-4)];

xj_o = importdata([img_path,'\xj.mat']);
mp_o = importdata([img_path,'\mp.mat']);
vd_o = importdata([img_path,'\vd.mat']);
bx_o = importdata([img_path,'\bx.mat']);

[nH,nLen] = size(xj_o);
xj = zeros(nH,nLen);
mp = zeros(nH,nLen);
vd = zeros(nH,nLen);
bx = zeros(nH,nLen);

for i = 1:nLen
    xj(1,i) = xj_o(1,nLen) - xj_o(1,nLen+1-i);
    mp(1,i) = abs(mp_o(1,nLen+1-i));
    vd(1,i) = vd_o(1,nLen+1-i);
    bx(1,i) = bx_o(1,nLen+1-i);
end

save([img_path,'\xj_d.mat'], 'xj'); 
save([img_path,'\mp_d.mat'], 'mp'); 
save([img_path,'\vd_d.mat'], 'vd'); 
save([img_path,'\bx_d.mat'], 'bx'); 

figure(1);
plot(xj,mp);
xlabel('x');ylabel('mp');
print(gcf,'-dpng',[img_path,'\mpx.png'])
figure(2);
plot(bx,mp);
xlabel('B');ylabel('mp');
print(gcf,'-dpng',[img_path,'\mpb.png'])
figure(3);
plot(vd,mp);
xlabel('阻力');ylabel('mp');
print(gcf,'-dpng',[img_path,'\mpf.png'])