[FileName,PathName] = uigetfile('*.avi','选择视频文件');
if exist('nXmin','var')&&exist('nXmax','var')
    def1 = num2str(nXmin);
    def2 = num2str(nXmax);
else
    def1 = '1';
    def2 = '720';
end
value_input = inputdlg({'左边界','右边界'},'左右边界设定',1,{def1,def2});
dlg1=waitbar(0,'正在计算...');
%————————————————参数设置———————————————————%
dPPC = 300;%图像分辨率，每厘米包含的像素数
nFitN = 4;%拟合阶数
nOx = 500;%空间坐标系的坐标原点在图像中的横坐标(pixel)
nDirection = -1;%1表示定义图像中向右为正方向，-1表示向左为正方向。
nXmin = str2num(value_input{1});%左边界
nXmax = str2num(value_input{2});%右边界
VideoName = FileName;%视频文件名
%————————————————读取视频———————————————————%
Mov = VideoReader([PathName,VideoName]);
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
else
    rmdir(img_path,'s');
    mkdir(img_path);
end
mkdir([img_path,'\image']);
%————————————————计算st————————————————————%
dMPP = 1/(dPPC*100);%每个像素多长（单位：m）
img_background = zeros(nHeight,nWidth);
nAverageNum = 1;
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
min_img_sum = min(tmp_sum);
% dThreshold = max_img_sum/2;%筛选有球图像的阈值
dThreshold = 160000;%mean(tmp_sum);
% dThreshold = 850000;
xt_pix = zeros(1,1);%小球横坐标数组（以像素为单位）

img_all_point = zeros(nHeight,nWidth);
file_name_all_point = [img_path,'/all_point.png'];
img_all_ball = zeros(nHeight,nWidth);
file_name_all_ball = [img_path,'/all_ball.png'];

img_index = 0;
countofpoints = 0;
for k = 1:nFrames
    img = double(rgb2gray(read(Mov,k)));
    img_s0 = -(img-img_background);
    img_s = img_filter1(img_s0);
    img_sum = sum(img_s(:));%像素和与dThreshold比较，判断是否有球
    if img_sum>dThreshold
        [ny,nx] = get_ball_yx(img_s);
        if (nx>nXmin&&nx<nXmax)
            countofpoints = countofpoints+1;
            img_index = img_index+1;
            xt_pix(1,img_index) = nx;
            img_all_point(round(ny),round(nx)) = 1;
            img_binaryzation = get_binaryzation(img_s);            
            imwrite_gray(img_s,[img_path,'\image\g_',num2str(img_index),'_',num2str(k),'.png'],[0,255]);
            imwrite_gray(img,[img_path,'\image\img_',num2str(img_index),'_',num2str(k),'.png'],[0,255]);
            imwrite(img_binaryzation,[img_path,'\image\',num2str(img_index),'_',num2str(k),'.png']);
            img_all_ball = img_all_ball+img_binaryzation;
        end
    end
    waitbar((k/nFrames)*(1-tmp_waitbar)+tmp_waitbar,dlg1);
end
imwrite(img_all_point,file_name_all_point);
imwrite(img_all_ball,file_name_all_ball);

close(dlg1);

t = zeros(1,img_index);
xt = zeros(1,img_index);
for k = 1:img_index
    t(k) = (k-1)*dFrameTime;
    xt(k) = nDirection*(xt_pix(k)-nOx)*dMPP;
end
save([img_path,'/t.mat'], 't'); 
save([img_path,'/xt.mat'], 'xt'); 

figure(1);
imshow(img_all_point,[]);
figure(2);
imshow(img_background,[]);
figure(3);
plot(tmp_sum);