[VideoName,PathName] = uigetfile('*.avi','ѡ����Ƶ�ļ�');
Mov = VideoReader([PathName,VideoName]);
nFrames = Mov.NumberOfFrames;%��Ƶ֡��
dFrameRate = double(Mov.FrameRate);%��Ƶ֡�ʣ�����Ƶÿ��֡��

def1 = '0';
def2 = num2str(Mov.Duration);
value_input = inputdlg({'��ʼʱ��','����ʱ��'},'ʱ���趨',1,{def1,def2});
Tmin = str2num(value_input{1});%��߽�
Tmax = str2num(value_input{2});%�ұ߽�
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