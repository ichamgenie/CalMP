[VideoName,PathName] = uigetfile('*.avi','选择视频文件');
Mov = VideoReader(VideoName);
nFrames = Mov.NumberOfFrames;%视频帧数
dFrameRate = double(Mov.FrameRate);%视频帧率，即视频每秒帧数
GifName = 'drop.gif';
nRate = 4;
N = round(nFrames/nRate);
for i = 1:N
    k = i*nRate+0;
    img_tmp = read(Mov,k);
    [I,map]=rgb2ind(img_tmp,256);
    if i==1;
        imwrite(I,map,GifName,'gif','Loopcount',inf,...
            'DelayTime',1*nRate/dFrameRate);%loopcount只是在i==1的时候才有用
    else
        imwrite(I,map,GifName,'gif','WriteMode','append',...
            'DelayTime',1*nRate/dFrameRate);%dlayTime用于设置gif文件的播放快慢
    end
end
