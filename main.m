% function [ output_args ] = main( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%ÿ����Ҫ����pic.mat����MATLAB�����ļ����еõ�
Mov=mmreader('video0014.avi'); %������Ƶ
mov=read(Mov);
fnum= Mov.NumberOfFrames; 
aa=round(fnum/1)-1;%֮ǰ����10
for i=1:(aa-1)
    j=i*1;
    pic(i).cdata=mov(:,:,:,j);
    
end
%ÿ����Ҫ����pic.mat����MATLAB�����ļ����еõ�����Ϊ������Ƶ����


for i=1:size(pic,2)
    bb=pic(i).cdata;
    pic_h(:,:,i)=rgb2gray(bb);
%     figure(i)
%     imshow(pic_h(:,:,i));
end
% figure(1)
% imshow(pic_h(:,:,1));
% figure(2)
% imshow(pic_h(:,:,50));
% ww=pic_h(:,:,1)-pic_h(:,:,50);
% imshow(ww);

% %����Һ�����
% for i=1:size(pic,2)-1
%     pic_m(:,:,i)=pic_h(:,:,1)-pic_h(:,:,i+1);%ÿ��ͼ�����һ�����
%     th=10;
%     pic_m(:,:,i)=im2bw(pic_m(:,:,i),th/255);%��ֵ�ָ� thΪ��ֵ
% 
%     croping=imcrop(pic_m(:,:,i),[]);%�ֶ���ȡͼ��һ����
%     [a,b]=find(croping~=0);%�Ҷ�ֵ������0������
%     qq=size(a);
%     sum1(i)=qq(1);%ÿ��ͼ�Ҷ�ֵ������0�����������
% end



% figure(1)
% imshow(pic_h(:,:,5),[]);
% [y1,x1]=getpts;
% %choose a set of points using mouse and return coordinate
% x1=round(x1);
% %the nearest integers
% y1=round(y1);
% biao=double(pic_h(x1,y1,5));
% pic_h=double(pic_h);
% for i=1:size(pic,2)
%     pic_h(x1,y1,i)=double(pic_h(x1,y1,i));
%     pic_h(:,:,i)=pic_h(:,:,i)./biao.*pic_h(x1,y1,i);
% %     figure(i)
% %     imshow(pic_h2(:,:,i),[]);
% end


%����Һ���ٶ�
for i=1:size(pic_h,3)
    figure(100)
    imshow(pic_h(:,:,i),[]);
    axis([0,720,0,480]);
    grid on;
    axis on;
% ���öϵ���������꣨�ڴ˼��жϣ�

%1Export Cursor to workspace  2Create new datatip  3Export Cursor to workspace
%4Enter
%     x2=cursor_info(1,1).Position(1);

     
x(i)=cursor_info(1,1).Position(1);%xΪ������λ��
%     x3=cursor_info(1,2).Position(1);
%     y3=cursor_info(1,2).Position(2);
%     wide=y2-y3;
%     Y=y2;
%     X=x3;
%     jianbian( X,Y,wide,pic_h,pic );
%     fenxi(X,Y,wide,pic_h,pic);
end

for i=1:(size(pic_h,3)-2)
    xx(i)=x(i+1);
    vv(i)=x(i)-x(i+2);
end

ss=b;