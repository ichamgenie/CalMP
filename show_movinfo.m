[FileName,PathName] = uigetfile('*.avi','ѡ����Ƶ�ļ�');
Mov = VideoReader(FileName);
i = Mov.NumberOfFrames;
img = rgb2gray(read(Mov,i));
imwrite_gray(img,'tmp2.png',[0,255]);