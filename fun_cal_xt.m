function [image_path,dFrameTime] = fun_cal_xt(fileFullPath, oxindex, pixelpcm, range_left, range_right)
%���������������������������������������á�������������������������������������%
dPPC = pixelpcm;%ͼ��ֱ��ʣ�ÿ���װ�����������
nOx = oxindex;%�ռ�����ϵ������ԭ����ͼ���еĺ�����(pixel)
nDirection = 1;%1��ʾ����ͼ��������Ϊ������-1��ʾ����Ϊ������
nXmin = range_left;%str2num(value_input{1});%��߽�
nXmax = range_right;%str2num(value_input{2});%�ұ߽�
%����������������������������������ȡ��Ƶ��������������������������������������%
Mov = VideoReader(fileFullPath);
nFrames = Mov.NumberOfFrames;%��Ƶ֡��
dFrameRate = double(Mov.FrameRate);%��Ƶ֡�ʣ�����Ƶÿ��֡��
dFrameTime = 1/dFrameRate;%ÿ��֮֡���ʱ����
nHeight = double(Mov.Height);
nWidth = double(Mov.Width);
if nXmax>nWidth
    nXmax = nWidth;
end
VideoPath = Mov.Path;
VideoName = Mov.Name;

[tmp,VideoNameLength] = size(VideoName);
image_path = [VideoPath,'/',VideoName(1:VideoNameLength-4)];
if ~isdir(image_path)
    mkdir(image_path);
else
    rmdir(image_path,'s');
    mkdir(image_path);
end
mkdir([image_path,'\image']);
%������������������������������������st����������������������������������������%
dMPP = 1/(dPPC*100);%ÿ�����ض೤����λ��m��
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
end
max_img_sum = max(tmp_sum);
min_img_sum = min(tmp_sum);
% dThreshold = max_img_sum/2;%ɸѡ����ͼ�����ֵ
dThreshold = mean(tmp_sum);
% dThreshold = 850000;
xt_pix = zeros(1,1);%С����������飨������Ϊ��λ��

img_all_point = zeros(nHeight,nWidth);
file_name_all_point = [image_path,'/all_point.png'];
img_all_ball = zeros(nHeight,nWidth);
file_name_all_ball = [image_path,'/all_ball.png'];

img_index = 0;
countofpoints = 0;
for k = 1:nFrames
    img = double(rgb2gray(read(Mov,k)));
    img_s0 = -(img-img_background);
    img_s = img_filter1(img_s0);
    img_sum = sum(img_s(:));%���غ���dThreshold�Ƚϣ��ж��Ƿ�����
    if img_sum>dThreshold
        [ny,nx] = get_ball_yx(img_s);
        if (nx>nXmin&&nx<nXmax)
            countofpoints = countofpoints+1;
            img_index = img_index+1;
            xt_pix(1,img_index) = nx;
            img_all_point(round(ny),round(nx)) = 1;
            img_binaryzation = get_binaryzation(img_s);
            imwrite_gray(img_s,[image_path,'\image\g_',num2str(img_index),'_',num2str(k),'.png'],[0,255]);
            imwrite_gray(img,[image_path,'\image\img_',num2str(img_index),'_',num2str(k),'.png'],[0,255]);
            imwrite(img_binaryzation,[image_path,'\image\',num2str(img_index),'_',num2str(k),'.png']);
            img_all_ball = img_all_ball+img_binaryzation;
        end
    end
end
imwrite(img_all_point,file_name_all_point);
imwrite(img_all_ball,file_name_all_ball);


t = zeros(1,img_index);
xt = zeros(1,img_index);
for k = 1:img_index
    t(k) = (k-1)*dFrameTime;
    xt(k) = nDirection*(xt_pix(k)-nOx)*dMPP;
end
save([image_path,'/t.mat'], 't'); 
save([image_path,'/xt.mat'], 'xt'); 