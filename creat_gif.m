[VideoName,PathName] = uigetfile('*.avi','ѡ����Ƶ�ļ�');
Mov = VideoReader(VideoName);
nFrames = Mov.NumberOfFrames;%��Ƶ֡��
dFrameRate = double(Mov.FrameRate);%��Ƶ֡�ʣ�����Ƶÿ��֡��
GifName = 'drop.gif';
nRate = 4;
N = round(nFrames/nRate);
for i = 1:N
    k = i*nRate+0;
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
