[VideoName,PathName] = uigetfile('*.avi','ѡ����Ƶ�ļ�');
Mov = VideoReader(VideoName);
nFrames = Mov.NumberOfFrames;%��Ƶ֡��
dFrameRate = double(Mov.FrameRate);%��Ƶ֡�ʣ�����Ƶÿ��֡��

def1 = '0';
def2 = num2str(Mov.Duration);
value_input = inputdlg({'��ʼʱ��','����ʱ��'},'ʱ���趨',1,{def1,def2});
Tmin = str2num(value_input{1});%��߽�
Tmax = str2num(value_input{2});%�ұ߽�
Framemin = round(Tmin*dFrameRate);
Framemax = round(Tmax*dFrameRate);

GifName = 'drop.gif';
nRate = 2;%���֡������ʾÿ��nRate֡ȡһ��ͼ������Խ��gif֡��Խ��
N = round((Framemax-Framemin)/nRate);
for i = 1:N
    k = i*nRate+Framemin;
    img_tmp = read(Mov,k);
    [I,map]=rgb2ind(img_tmp,256);
    if i==1;
        imwrite(I,map,GifName,'gif','Loopcount',inf,...
            'DelayTime',1*nRate/dFrameRate);%loopcountֻ����i==1��ʱ�������
    else
        imwrite(I,map,GifName,'gif','WriteMode','append',...
            'DelayTime',1*nRate/dFrameRate);%dlayTime��������gif�ļ��Ĳ��ſ���
    end
end
