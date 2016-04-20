[VideoName,PathName] = uigetfile('*.avi','选择视频文件');
Mov = VideoReader([PathName,VideoName]);
nFrames = Mov.NumberOfFrames;%视频帧数
dFrameRate = double(Mov.FrameRate);%视频帧率，即视频每秒帧数

def1 = '0';
def2 = num2str(Mov.Duration);
value_input = inputdlg({'起始时间','结束时间'},'时间设定',1,{def1,def2});
Tmin = str2num(value_input{1});%左边界
Tmax = str2num(value_input{2});%右边界
Framemin = round(Tmin*dFrameRate);
Framemax = round(Tmax*dFrameRate);
if Framemin<1
    Framemin = 1;
end
if Framemax>nFrames
    Framemax = nFrames;
end
[tmp,VideoNameLength] = size(VideoName);
img_path = [PathName,VideoName(1:VideoNameLength-4)];
cv = cutVideo([PathName,VideoName],[img_path,'_2.avi'],Framemin,Framemax);