function rt_img = get_binaryzation(img)
[nH,nW] = size(img);
rt_img = zeros(nH,nW);
img_max = max(max(img));
dThreshold = img_max/2;
for j = 1:nH
    for i = 1:nW
        if img(j,i)>dThreshold
            rt_img(j,i) = 1;
        end
    end
end