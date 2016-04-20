path = 'F:\Experiment1127\71\02\';%原始图片文件夹
gifFrameRate = 12;%gif帧率
rate = 10;%慢放倍数
images = dir([path,'*.bmp']);
fileCount = length(images);
dFrameRate = 4000;
step = round(dFrameRate/(gifFrameRate*rate));
GifName = 'drop.gif';
i = 1;
while(i<fileCount)
    image = imread([path,images(i).name]);
    if i==1;
        imwrite(image,GifName,'gif','Loopcount',inf,...
            'DelayTime',1/gifFrameRate);
    else
        imwrite(image,GifName,'gif','WriteMode','append',...
            'DelayTime',1/gifFrameRate);
    end
    i = i+step;
end
imshow(image,[]);


