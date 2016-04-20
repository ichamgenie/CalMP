function [image_path,dFrameTime] = tmp_fun_cal_xt_by_xt_pix(fileFullPath, oxindex, pixelpcm, range_left, range_right, startIndex, endIndex)
%���������������������������������������á�������������������������������������%
dPPC = pixelpcm;%ͼ��ֱ��ʣ�ÿ���װ�����������
nOx = oxindex;%�ռ�����ϵ������ԭ����ͼ���еĺ�����(pixel)
nDirection = 1;%1��ʾ����ͼ��������Ϊ������-1��ʾ����Ϊ������
nXmin = range_left;%str2num(value_input{1});%��߽�
nXmax = range_right;%str2num(value_input{2});%�ұ߽�
%����������������������������������ȡ��Ƶ��������������������������������������%
Mov = VideoReader(fileFullPath);
dFrameRate = double(Mov.FrameRate);%��Ƶ֡�ʣ�����Ƶÿ��֡��
dFrameTime = 1/dFrameRate;%ÿ��֮֡���ʱ����
VideoPath = Mov.Path;
VideoName = Mov.Name;

[tmp,VideoNameLength] = size(VideoName);
image_path = [VideoPath,'/',VideoName(1:VideoNameLength-4)];
dMPP = 1/(dPPC*100);%ÿ�����ض೤����λ��m��
xt_pix = importdata([image_path,'\xt_pix.mat']);
[tmp2,img_index] = size(xt_pix);

t = zeros(1,img_index);
xt = zeros(1,img_index);
for k = 1:img_index
    t(k) = (k-1)*dFrameTime;
    xt(k) = nDirection*(xt_pix(k)-nOx)*dMPP;
end
save([image_path,'/t.mat'], 't'); 
save([image_path,'/xt.mat'], 'xt'); 