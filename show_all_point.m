 %��ʾ���е�
[FileName,PathName] = uigetfile('*.avi','ѡ����Ƶ�ļ�');
dlg1=waitbar(0,'���ڼ���...');
VideoName = FileName;%'video0004.avi';%��Ƶ�ļ���
Mov = VideoReader([PathName,VideoName]);
nFrames = Mov.NumberOfFrames;%��Ƶ֡��
nHeight = double(Mov.Height);
nWidth = double(Mov.Width);

img_background = zeros(nHeight,nWidth);
nAverageNum = 1;
for i = 1:nAverageNum
    img = rgb2gray(read(Mov,i));
    img_background = img_background + double(img)/nAverageNum;
end
tmp_sum = zeros(nFrames,1);%ԭʼͼ���ȥ����ͼ�������ֵ��ͣ����ڼ���dThreshold
tmp_waitbar = 0.3;
for i = 1:nFrames
    img = double(rgb2gray(read(Mov,i)));
    img_s0 = -(img-img_background);
    img_s = img_filter1(img_s0);
    tmp_sum(i) = sum(img_s(:));
    waitbar((i/nFrames)*tmp_waitbar,dlg1);
end
max_img_sum = max(tmp_sum);
% dThreshold = max_img_sum/2;%ɸѡ����ͼ�����ֵ
% dThreshold = mean(tmp_sum);
dThreshold = 150000;
st_pix = zeros(1,1);%С����������飨������Ϊ��λ��

img_all_point = zeros(nHeight,nWidth);
countofpoints = 0;
for k = 1:nFrames
    img = double(rgb2gray(read(Mov,k)));
    img_s0 = -(img-img_background);
    img_s = img_filter1(img_s0);
    img_sum = sum(img_s(:));%���غ���dThreshold�Ƚϣ��ж��Ƿ�����
    if img_sum>dThreshold
        countofpoints = countofpoints+1;
        [ny,nx] = get_ball_yx(img_s);
        img_all_point(round(ny),round(nx)) = 1;
    end
    waitbar((k/nFrames)*(1-tmp_waitbar)+tmp_waitbar,dlg1);
end

close(dlg1);
figure(1);
imshow(img_all_point,[]);
figure(2);
imshow(img_background,[]);
figure(3);
plot(tmp_sum);

