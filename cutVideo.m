function cv = cutVideo(srcFile, destFile, startIndex, endIndex)
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
 
cv = 0;