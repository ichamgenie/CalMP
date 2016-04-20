[FileName,PathName] = uigetfile('*.avi','选择视频文件');
dlg1=waitbar(0,'正在计算...');
VideoName = FileName;%'video0004.avi';%视频文件名
Mov = VideoReader(VideoName);
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
    img_s = -(img-img_background);
    tmp_sum(i) = sum(img_s(:));
    waitbar((i/nFrames)*tmp_waitbar,dlg1);
end
max_img_sum = max(tmp_sum);
dThreshold = max_img_sum/2;%筛选有球图像的阈值
st_pix = zeros(1,1);%小球横坐标数组（以像素为单位）

img_back1 = read(Mov,1);

%img_back1 = img_back1/back_max;
img_back2 = double(img_back1);%ones(nHeight,nWidth,3);
back_max = max(max(max(img_back2)));
img_all_point = img_back2/back_max;
img_all_point = zeros(nHeight,nWidth,3);

for k = 1:nFrames
    img = double(rgb2gray(read(Mov,k)));
    img_s = -(img-img_background);
    img_sum = sum(img_s(:));%像素和与dThreshold比较，判断是否有球
    if img_sum>dThreshold
        [ny,nx] = get_ball_yx(img_s);
        img_all_point(round(ny),round(nx),1) = 0;
        img_all_point(round(ny),round(nx),2) = 0;
        img_all_point(round(ny),round(nx),3) = 1;
        img_all_point(round(ny)+1,round(nx),1) = 0;
        img_all_point(round(ny)+1,round(nx),2) = 0;
        img_all_point(round(ny)+1,round(nx),3) = 1;
        img_all_point(round(ny),round(nx)+1,1) = 0;
        img_all_point(round(ny),round(nx)+1,2) = 0;
        img_all_point(round(ny),round(nx)+1,3) = 1;
        img_all_point(round(ny)+1,round(nx)+1,1) = 0;
        img_all_point(round(ny)+1,round(nx)+1,2) = 0;
        img_all_point(round(ny)+1,round(nx)+1,3) = 1;
    end
    waitbar((k/nFrames)*(1-tmp_waitbar)+tmp_waitbar,dlg1);
end

close(dlg1);
figure(1);
imshow(img_all_point,[]);
figure(2);
imshow(img_background,[]);
figure(3);
imshow(img_back1,[]);
img_write = img_all_point;
imwrite(img_write,'0029_3.png');
