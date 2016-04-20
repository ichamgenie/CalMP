 %显示所有点
[FileName,PathName] = uigetfile('*.avi','选择视频文件');
dlg1=waitbar(0,'正在计算...');
VideoName = FileName;%'video0004.avi';%视频文件名
Mov = VideoReader([PathName,VideoName]);
nFrames = Mov.NumberOfFrames;%视频帧数
nHeight = double(Mov.Height);
nWidth = double(Mov.Width);

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
% dThreshold = max_img_sum/2;%筛选有球图像的阈值
% dThreshold = mean(tmp_sum);
dThreshold = 150000;
st_pix = zeros(1,1);%小球横坐标数组（以像素为单位）

img_all_point = zeros(nHeight,nWidth);
countofpoints = 0;
for k = 1:nFrames
    img = double(rgb2gray(read(Mov,k)));
    img_s0 = -(img-img_background);
    img_s = img_filter1(img_s0);
    img_sum = sum(img_s(:));%像素和与dThreshold比较，判断是否有球
    if img_sum>dThreshold
        countofpoints = countofpoints+1;
        [ny,nx] = get_ball_yx(img_s);
        img_all_point(round(ny),round(nx)) = 1;
    end
    waitbar((k/nFrames)*(1-tmp_waitbar)+tmp_waitbar,dlg1);
end

close(dlg1);
figure(1);
imshow(img_all_point,[]);
figure(2);
imshow(img_background,[]);
figure(3);
plot(tmp_sum);

