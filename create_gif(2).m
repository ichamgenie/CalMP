[VideoName,PathName] = uigetfile('*.avi','选择视频文件');
Mov = VideoReader(VideoName);
nFrames = Mov.NumberOfFrames;%视频帧数
dFrameRate = double(Mov.FrameRate);%视频帧率，即视频每秒帧数

def1 = '0';
def2 = num2str(Mov.Duration);
value_input = inputdlg({'起始时间','结束时间'},'时间设定',1,{def1,def2});
Tmin = str2num(value_input{1});%左边界
Tmax = str2num(value_input{2});%右边界
Framemin = round(Tmin*dFrameRate);
Framemax = round(Tmax*dFrameRate);

GifName = 'drop.gif';
nRate = 2;%间隔帧数，表示每隔nRate帧取一张图，数字越大gif帧率越低
N = round((Framemax-Framemin)/nRate);
for i = 1:N
    k = i*nRate+Framemin;
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
