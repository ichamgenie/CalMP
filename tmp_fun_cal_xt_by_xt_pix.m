function [image_path,dFrameTime] = tmp_fun_cal_xt_by_xt_pix(fileFullPath, oxindex, pixelpcm, range_left, range_right, startIndex, endIndex)
%————————————————参数设置———————————————————%
dPPC = pixelpcm;%图像分辨率，每厘米包含的像素数
nOx = oxindex;%空间坐标系的坐标原点在图像中的横坐标(pixel)
nDirection = 1;%1表示定义图像中向右为正方向，-1表示向左为正方向。
nXmin = range_left;%str2num(value_input{1});%左边界
nXmax = range_right;%str2num(value_input{2});%右边界
%————————————————读取视频———————————————————%
Mov = VideoReader(fileFullPath);
dFrameRate = double(Mov.FrameRate);%视频帧率，即视频每秒帧数
dFrameTime = 1/dFrameRate;%每两帧之间的时间间隔
VideoPath = Mov.Path;
VideoName = Mov.Name;

[tmp,VideoNameLength] = size(VideoName);
image_path = [VideoPath,'/',VideoName(1:VideoNameLength-4)];
dMPP = 1/(dPPC*100);%每个像素多长（单位：m）
xt_pix = importdata([image_path,'\xt_pix.mat']);
[tmp2,img_index] = size(xt_pix);

t = zeros(1,img_index);
xt = zeros(1,img_index);
for k = 1:img_index
    t(k) = (k-1)*dFrameTime;
    xt(k) = nDirection*(xt_pix(k)-nOx)*dMPP;
end
save([image_path,'/t.mat'], 't'); 
save([image_path,'/xt.mat'], 'xt'); 