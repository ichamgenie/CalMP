function rt1 = imwrite_gray(img,img_name,gray_range)
pmin = gray_range(1);
pmax = gray_range(2);
[nH,nW] = size(img);
img_write = zeros(nH,nW);
for j = 1:nH
    for i = 1:nW
        tmp = double(img(j,i));
        img_write(j,i) = (tmp-pmin)/(pmax-pmin);
    end
end
imwrite(img_write,img_name);
rt1 = 0;