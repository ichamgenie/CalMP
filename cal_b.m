bdata = load('B_new.csv');%�Լ�������
xshift = -0.01;%�ų����ұߵĵ��������ԭ��Ŀռ���룬������ԭ���ұ�Ϊ��ֵ��������ԭ�����Ϊ������λ����
bx2 = bdata';
bx = bx2;
[nH,nW] = size(bx2);
for i = 1:nW
    bx(i) = bx2(nW-i+1);
end
x = 0+xshift:0.001:(nW-1)*0.001+xshift;%��㣺�������յ㣨��λ����
bx_para = polyfit(x,bx,7);
save('bx_para.mat', 'bx_para'); 
xi = 0+xshift:0.001:(nW-1)*0.001+xshift;%0+xshift:0.0002:0.001+xshift;
bi=polyval(bx_para,xi);  
figure(1);
plot(xi,bi,x,bx,'r.'); 
xlabel('x');ylabel('B');