[FileName,PathName] = uigetfile('*.avi','选择视频文件');

VideoName = FileName;%'video0004.avi';%视频文件名
Mov = VideoReader(VideoName);
nFrames = Mov.NumberOfFrames;%视频帧数
nHeight = double(Mov.Height);
nWidth = double(Mov.Width);

img_background = zeros(nHeight,nWidth);
nAverageNum = 5;
for i = 1:nAverageNum
    img = rgb2gray(read(Mov,i));
    img_background = img_background + double(img)/nAverageNum;
end
for j = 1:nHeight
    for i = 1:nWidth
        if img_background(j,i)<0;
            img_background(j,i) = 0;
        end
    end
end

img1 = double(rgb2gray(read(Mov,100)));
img_s1 = -(img1-img_background);
img_out = img_filter1(img_s1);



figure(1);
imshow(img1,[]);
figure(2);
imshow(img_out,[]);
