mp1 = importdata('F:\cal\20160325\01\mp1.mat');
xj1 = importdata('F:\cal\20160325\01\xj1.mat');
mp2 = importdata('F:\cal\20160325\02-naoh\mp1.mat');
xj2 = importdata('F:\cal\20160325\02-naoh\xj1.mat');
mp3 = importdata('F:\cal\20160325\03-5000\mp1.mat');
xj3 = importdata('F:\cal\20160325\03-5000\xj1.mat');
mp4 = importdata('F:\cal\20160325\04-7000\mp1.mat');
xj4 = importdata('F:\cal\20160325\04-7000\xj1.mat');
mp5 = importdata('F:\cal\20160325\05-naoh\mp1.mat');
xj5 = importdata('F:\cal\20160325\05-naoh\xj1.mat');

idxmin = 5;
idxmax = 40;
xj01_1draw = xj1(idxmin:idxmax);
mp01_1draw = mp1(idxmin:idxmax);
xj02_1draw = xj2(idxmin:idxmax);
mp02_1draw = mp2(idxmin:idxmax);
xj03_1draw = xj3(idxmin:idxmax);
mp03_1draw = mp3(idxmin:idxmax);
xj04_1draw = xj4(idxmin:idxmax);
mp04_1draw = mp4(idxmin:idxmax);
xj05_1draw = xj5(idxmin:idxmax);
mp05_1draw = mp5(idxmin:idxmax);

figure(1);
plot(xj1,mp1,'r-');
hold on;
plot(xj2,mp2,'g-');
hold on;
plot(xj3,mp3,'b-');
hold on;
plot(xj4,mp4,'y-');
hold on;
plot(xj5,mp5,'c-');
hold on;

figure(2);
plot(xj01_1draw,mp01_1draw,'r-');
hold on;
% plot(xj02_1draw,mp02_1draw,'m-');
% hold on;
plot(xj03_1draw,mp03_1draw,'b-');
hold on;
plot(xj04_1draw,mp04_1draw,'y-');
hold on;
plot(xj05_1draw,mp05_1draw,'c-');
hold on;