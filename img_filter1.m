function img_out = img_filter1(img_in)
img_tmp = img_in;
[nH,nW] = size(img_in);
for j = 1:nH
    for i = 1:nW
        if img_tmp(j,i)<0;
            img_tmp(j,i) = 0;
        end
    end
end
img_out = img_tmp;