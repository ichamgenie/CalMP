img28 = imread('0028_3.png');
img29 = imread('0029_3.png');
img_combine1 = img28+img29;
imshow(img_combine1,[]);
imwrite(img_combine1,'combine.png');