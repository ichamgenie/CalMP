[FileName,PathName] = uigetfile('*.avi','ѡ����Ƶ�ļ�');
if exist('nXmin','var')&&exist('nXmax','var')
    def1 = num2str(nXmin);
    def2 = num2str(nXmax);
else
    def1 = '1';
    def2 = '720';
end
value_input = inputdlg({'��߽�','�ұ߽�'},'���ұ߽��趨',1,{def1,def2});
% dlg1 = helpdlg('���ڼ���...',' ');
dlg1=waitbar(0,'���ڼ���...');
%���������������������������������������á�������������������������������������%
dPPC = 200;%ͼ��ֱ��ʣ�ÿ���װ�����������
nFitN = 4;%��Ͻ���
nOx = 0;%�ռ�����ϵ������ԭ����ͼ���еĺ�����(pixel)
nXmin = str2num(value_input{1});%��߽�
nXmax = str2num(value_input{2});%�ұ߽�
% nXmin = 371;%��߽�
% nXmax = 663;%�ұ߽�
VideoName = FileName;%'video0004.avi';%��Ƶ�ļ���
%����������������������������������ȡ��Ƶ��������������������������������������%
Mov = VideoReader(VideoName);
nFrames = Mov.NumberOfFrames;%��Ƶ֡��
dFrameRate = Mov.FrameRate;%��Ƶ֡�ʣ�����Ƶÿ��֡��
dFrameTime = 1/dFrameRate;%ÿ��֮֡���ʱ����
nHeight = double(Mov.Height);
nWidth = double(Mov.Width);
if nXmax>nWidth
    nXmax = nWidth;
end
VideoPath = Mov.Path;

[tmp,VideoNameLength] = size(VideoName);
img_path = [VideoPath,'/',VideoName(1:VideoNameLength-4)];
if ~isdir(img_path)
    mkdir(img_path);
end
%������������������������������������st����������������������������������������%
dMPP = 1/(dPPC*100);%ÿ�����ض೤����λ��m��
img_background = zeros(nHeight,nWidth);
nAverageNum = 3;
for i = 1:nAverageNum
    img = rgb2gray(read(Mov,i));
    img_background = img_background + double(img)/nAverageNum;
end
tmp_sum = zeros(nFrames,1);%ԭʼͼ���ȥ����ͼ�������ֵ��ͣ����ڼ���dThreshold
tmp_waitbar = 0.3;
for i = 1:nFrames
    img = double(rgb2gray(read(Mov,i)));
    img_s = -(img-img_background);
    tmp_sum(i) = sum(img_s(:));
    waitbar((i/nFrames)*tmp_waitbar,dlg1);
end
max_img_sum = max(tmp_sum);
dThreshold = max_img_sum/2;%ɸѡ����ͼ�����ֵ
xt_pix = zeros(1,1);%С����������飨������Ϊ��λ��

img_all_point = zeros(nHeight,nWidth);
file_name_all_point = [img_path,'/all_point.png'];
img_all_ball = zeros(nHeight,nWidth);
file_name_all_ball = [img_path,'/all_ball.png'];

img_index = 0;
for k = 1:nFrames
    img = double(rgb2gray(read(Mov,k)));
    img_s = -(img-img_background);
    img_sum = sum(img_s(:));%���غ���dThreshold�Ƚϣ��ж��Ƿ�����

    if img_sum>dThreshold
        [ny,nx] = get_ball_yx(img_s);
        if (nx>nXmin&&nx<nXmax)
            img_index = img_index+1;
            xt_pix(1,img_index) = nx;
            img_all_point(round(ny),round(nx)) = 1;
            img_binaryzation = get_binaryzation(img_s);
            imwrite(img_binaryzation,[img_path,'/',num2str(img_index),'.png']);
            img_all_ball = img_all_ball+img_binaryzation;
        end
    end
    waitbar((k/nFrames)*(1-tmp_waitbar)+tmp_waitbar,dlg1);
end
imwrite(img_all_point,file_name_all_point);
imwrite(img_all_ball,file_name_all_ball);

close(dlg1);

t = zeros(1,img_index);
xt = zeros(1,img_index);
for k = 1:img_index
    t(k) = (k-1)*dFrameTime;
    xt(k) = (xt_pix(k)-nOx)*dMPP;
end

xt_para=polyfit(t,xt,nFitN);
vt_para = zeros(1,nFitN);
at_para = zeros(1,nFitN-1);
for ni = 1:nFitN
    tmpN = nFitN+1-ni;
    vt_para(ni) = tmpN*xt_para(ni);
    at_para(ni) = (tmpN-1)*vt_para(ni);
end
save([img_path,'/t.mat'], 't'); 
save([img_path,'/xt.mat'], 'xt'); 
save([img_path,'/xt_para.mat'], 'xt_para'); 
save([img_path,'/vt_para.mat'], 'vt_para'); 
save([img_path,'/at_para.mat'], 'at_para'); 

t_max = max(t);
ti=0:0.01:t_max;  
xi=polyval(xt_para,ti);  
vi=polyval(vt_para,ti); 
ai=polyval(at_para,ti); 
figure(1);
plot(ti,xi,t,xt,'r.'); 
xlabel('t');ylabel('x');
figure(2);
plot(ti,vi); 
xlabel('t');ylabel('v');
figure(3);
plot(ti,ai); 
xlabel('t');ylabel('a');
figure(4);
plot(xi,ai); 
xlabel('x');ylabel('a');