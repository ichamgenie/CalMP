Mov = VideoReader('video0004.avi');
nFrames = Mov.NumberOfFrames;
img1 = rgb2gray(read(Mov,90));
img2 = rgb2gray(read(Mov,1));
img = img2-img1;
imshow(img,[]);