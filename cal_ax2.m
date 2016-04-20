[FileName,PathName] = uigetfile('*.avi','选择视频文件');
if exist('nXmin','var')&&exist('nXmax','var')
    def1 = num2str(nXmin);
    def2 = num2str(nXmax);
else
    def1 = '1';
    def2 = '720';
end
value_input = inputdlg({'左边界','右边界'},'左右边界设定',1,{def1,def2});
% dlg1 = helpdlg('正在计算...',' ');
dlg1=waitbar(0,'正在计算...');
%————————————————参数设置———————————————————%
dPPC = 150;%图像分辨率，每厘米包含的像素数
nFitN = 4;%拟合阶数
nOx = 0;%空间坐标系的坐标原点在图像中的横坐标(pixel)
nDirection = 1;%
nXmin = str2num(value_input{1});%左边界
nXmax = str2num(value_input{2});%右边界
% nXmin = 371;%左边界
% nXmax = 663;%右边界
VideoName = FileName;%'video0004.avi';%视频文件名
%————————————————读取视频———————————————————%
Mov = VideoReader(VideoName);
nFrames = Mov.NumberOfFrames;%视频帧数
dFrameRate = double(Mov.FrameRate);%视频帧率，即视频每秒帧数
dFrameTime = 1/dFrameRate;%每两帧之间的时间间隔
nHeight = double(Mov.Height);
nWidth = double(Mov.Width);
if nXmax>nWidth
    nXmax = nWidth;
end
VideoPath = Mov.Path;

[tmp,VideoNameLength] = size(VideoName);
img_path = [VideoPath,'/',VideoName(1:VideoNameLength-4)];
if ~isdir(img_path)
    mkdir(img_path);
end
%————————————————计算st————————————————————%
dMPP = 1/(dPPC*100);%每个像素多长（单位：m）
img_background = zeros(nHeight,nWidth);
nAverageNum = 3;
for i = 1:nAverageNum
    img = rgb2gray(read(Mov,i));
    img_background = img_background + double(img)/nAverageNum;
end
tmp_sum = zeros(nFrames,1);%原始图像减去背景图像后像素值求和，用于计算dThreshold
tmp_waitbar = 0.3;
for i = 1:nFrames
    img = double(rgb2gray(read(Mov,i)));
    img_s0 = -(img-img_background);
    img_s = img_filter1(img_s0);
    tmp_sum(i) = sum(img_s(:));
    waitbar((i/nFrames)*tmp_waitbar,dlg1);
end
max_img_sum = max(tmp_sum);
dThreshold = max_img_sum/2;%筛选有球图像的阈值
xt_pix = zeros(1,1);%小球横坐标数组（以像素为单位）

img_all_point = zeros(nHeight,nWidth);
file_name_all_point = [img_path,'/all_point.png'];
img_all_ball = zeros(nHeight,nWidth);
file_name_all_ball = [img_path,'/all_ball.png'];

img_index = 0;
for k = 1:nFrames
    img = double(rgb2gray(read(Mov,k)));
    img_s0 = -(img-img_background);
    img_s = img_filter1(img_s0);
    img_sum = sum(img_s(:));%像素和与dThreshold比较，判断是否有球

    if img_sum>dThreshold
        [ny,nx] = get_ball_yx(img_s);
        if (nx>nXmin&&nx<nXmax)
            img_index = img_index+1;
            xt_pix(1,img_index) = nx;
            img_all_point(round(ny),round(nx)) = 1;
            img_binaryzation = get_binaryzation(img_s);
            imwrite(img_binaryzation,[img_path,'/',num2str(img_index),'.png']);
            img_all_ball = img_all_ball+img_binaryzation;
        end
    end
    waitbar((k/nFrames)*(1-tmp_waitbar)+tmp_waitbar,dlg1);
end
imwrite(img_all_point,file_name_all_point);
imwrite(img_all_ball,file_name_all_ball);

close(dlg1);

t1 = zeros(1,img_index);
xt1 = zeros(1,img_index);
t = zeros(1,img_index-2);
xt = zeros(1,img_index-2);
vt = zeros(1,img_index-2);
at = zeros(1,img_index-2);
for k = 1:img_index
    t1(k) = (k-1)*dFrameTime;
    xt1(k) = nDirection*(xt_pix(k)-nOx)*dMPP;
end
for k = 1:img_index-2
    t(k) = t1(k+1);
    xt(k) = xt1(k+1);
%     vt(k) = (xt1(k+2)-xt1(k))/(dFrameTime*2);
%     at(k) = (xt1(k+2)-2*xt1(k+1)+xt1(k))/(dFrameTime*dFrameTime);
end
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
save([img_path,'/t.mat'], 't'); 
save([img_path,'/xt.mat'], 'xt'); 

ax_para=polyfit(xt,at,nFitN);
vx_para=polyfit(xt,vt,nFitN);
dxstep = (dxmax-dxmin)/40;
xj = dxmin:dxstep:dxmax;
vj = polyval(vx_para,xj);
aj = polyval(ax_para,xj);
%Fgx_para = (2.5E-6)*ax_para+3*pi*(1.68E-6)*vx_para;
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
% figure(2);
% plot(t,vt,t,vt,'r.'); 
% xlabel('t');ylabel('v');
% figure(3);
% plot(t,at,t,at,'r.'); 
% xlabel('t');ylabel('a');
% % figure(4);
% % plot(xi,ai); 
% % xlabel('x');ylabel('a');
% % figure(5);
% % plot(xi,vi); 
% % xlabel('x');ylabel('v');
% figure(6);
% plot(xj,aj,xt,at,'r.'); 
% xlabel('x');ylabel('a');
% figure(7);
% plot(xj,vj,xt,vt,'r.'); 
% xlabel('x');ylabel('v');
