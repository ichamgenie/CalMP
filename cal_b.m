bdata = load('B_new.csv');%自己改名字
xshift = -0.01;%磁场最右边的点距离坐标原点的空间距离，在坐标原点右边为负值，在坐标原点左边为正，单位：米
bx2 = bdata';
bx = bx2;
[nH,nW] = size(bx2);
for i = 1:nW
    bx(i) = bx2(nW-i+1);
end
x = 0+xshift:0.001:(nW-1)*0.001+xshift;%起点：步长：终点（单位：米
bx_para = polyfit(x,bx,7);
save('bx_para.mat', 'bx_para'); 
xi = 0+xshift:0.001:(nW-1)*0.001+xshift;%0+xshift:0.0002:0.001+xshift;
bi=polyval(bx_para,xi);  
figure(1);
plot(xi,bi,x,bx,'r.'); 
xlabel('x');ylabel('B');