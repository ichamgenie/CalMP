% function [ output_args ] = main( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%每次需要更新pic.mat，从MATLAB处理文件运行得到
Mov=mmreader('video0014.avi'); %读入视频
mov=read(Mov);
fnum= Mov.NumberOfFrames; 
aa=round(fnum/1)-1;%之前除以10
for i=1:(aa-1)
    j=i*1;
    pic(i).cdata=mov(:,:,:,j);
    
end
%每次需要更新pic.mat，从MATLAB处理文件运行得到（此为读入视频程序）


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

% %计算液滴面积
% for i=1:size(pic,2)-1
%     pic_m(:,:,i)=pic_h(:,:,1)-pic_h(:,:,i+1);%每幅图像与第一幅相减
%     th=10;
%     pic_m(:,:,i)=im2bw(pic_m(:,:,i),th/255);%阈值分割 th为阈值
% 
%     croping=imcrop(pic_m(:,:,i),[]);%手动截取图像一部分
%     [a,b]=find(croping~=0);%灰度值不等于0的坐标
%     qq=size(a);
%     sum1(i)=qq(1);%每幅图灰度值不等于0的坐标点数和
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


%计算液滴速度
for i=1:size(pic_h,3)
    figure(100)
    imshow(pic_h(:,:,i),[]);
    axis([0,720,0,480]);
    grid on;
    axis on;
% 设置断点来获得坐标（在此加中断）

%1Export Cursor to workspace  2Create new datatip  3Export Cursor to workspace
%4Enter
%     x2=cursor_info(1,1).Position(1);

     
x(i)=cursor_info(1,1).Position(1);%x为横坐标位置
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