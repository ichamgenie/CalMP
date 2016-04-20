function [y,x] = get_ball_yx(img)
img_max = max(max(img));
dThreshold = img_max/2;
[nH,nW] = size(img);
sum1 = 0;
sumi = 0;
sumj = 0;
for j = 1:nH
    for i = 1:nW
        if img(j,i)>dThreshold
            sum1 = sum1 + 1;
            sumi = sumi + i;
            sumj = sumj + j;
        end
    end
end
y = sumj/sum1;
x = sumi/sum1;