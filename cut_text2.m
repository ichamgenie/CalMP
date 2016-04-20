srcFile = '069.avi';
destFile = '069_2.avi';
startIndex = 2530;
endIndex = 2585;
mov = VideoReader(srcFile);
% source = read(mov);
writerObj = VideoWriter(destFile);
writerObj.FrameRate = mov.FrameRate;
% writerObj.Height = mov.Height;
% writerObj.Width = mov.Width;
open(writerObj);
for i = startIndex:endIndex
    img = read(mov,i);
    writeVideo(writerObj,img);
end
close(writerObj);