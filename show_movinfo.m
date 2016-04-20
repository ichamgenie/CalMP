[FileName,PathName] = uigetfile('*.avi','选择视频文件');
Mov = VideoReader(FileName);
i = Mov.NumberOfFrames;
img = rgb2gray(read(Mov,i));
imwrite_gray(img,'tmp2.png',[0,255]);