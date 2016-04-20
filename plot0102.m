mp1 = importdata('E:\matlab cal new\01-1_2\mp1.mat');
xj1 = importdata('E:\matlab cal new\01-1_2\xj1.mat');
mp2 = importdata('E:\matlab cal new\01-2_2\mp1.mat');
xj2 = importdata('E:\matlab cal new\01-2_2\xj1.mat');
mp3 = importdata('E:\matlab cal new\01-3_2\mp1.mat');
xj3 = importdata('E:\matlab cal new\01-3_2\xj1.mat');
mp4 = importdata('E:\matlab cal new\01-4_2\mp1.mat');
xj4 = importdata('E:\matlab cal new\01-4_2\xj1.mat');
mp5 = importdata('E:\matlab cal new\01-5_2\mp1.mat');
xj5 = importdata('E:\matlab cal new\01-5_2\xj1.mat');
mp01 = (mp1+mp2+mp3+mp4+mp5)/5; %材料1离散
xj01 = (xj1+xj2+xj3+xj4+xj5)/5;

mp6 = importdata('E:\matlab cal new\02-1_2\mp1.mat');
xj6 = importdata('E:\matlab cal new\02-1_2\xj1.mat');
mp7 = importdata('E:\matlab cal new\02-2_2\mp1.mat');
xj7 = importdata('E:\matlab cal new\02-2_2\xj1.mat');
mp8 = importdata('E:\matlab cal new\02-3_2\mp1.mat');
xj8 = importdata('E:\matlab cal new\02-3_2\xj1.mat');
mp9 = importdata('E:\matlab cal new\02-4_2\mp1.mat');
xj9 = importdata('E:\matlab cal new\02-4_2\xj1.mat');
mp10 = importdata('E:\matlab cal new\02-5_2\mp1.mat');
xj10 = importdata('E:\matlab cal new\02-5_2\xj1.mat');
mp02 = (mp6+mp7+mp8+mp9+mp10)/5; %材料2离散
xj02 = (xj6+xj7+xj8+xj9+xj10)/5;

mp11 = importdata('E:\matlab cal new\01-1_2\mp2.mat');
xj11 = importdata('E:\matlab cal new\01-1_2\xj2.mat');
mp12 = importdata('E:\matlab cal new\01-2_2\mp2.mat');
xj12 = importdata('E:\matlab cal new\01-2_2\xj2.mat');
mp13 = importdata('E:\matlab cal new\01-3_2\mp2.mat');
xj13 = importdata('E:\matlab cal new\01-3_2\xj2.mat');
mp14 = importdata('E:\matlab cal new\01-4_2\mp2.mat');
xj14 = importdata('E:\matlab cal new\01-4_2\xj2.mat');
mp15 = importdata('E:\matlab cal new\01-5_2\mp2.mat');
xj15 = importdata('E:\matlab cal new\01-5_2\xj2.mat');
mp03 = (mp11+mp12+mp13+mp14+mp15)/5; %材料1拟合
xj03 = (xj11+xj12+xj13+xj14+xj15)/5;

mp16 = importdata('E:\matlab cal new\02-1_2\mp2.mat');
xj16 = importdata('E:\matlab cal new\02-1_2\xj2.mat');
mp17 = importdata('E:\matlab cal new\02-2_2\mp2.mat');
xj17 = importdata('E:\matlab cal new\02-2_2\xj2.mat');
mp18 = importdata('E:\matlab cal new\02-3_2\mp2.mat');
xj18 = importdata('E:\matlab cal new\02-3_2\xj2.mat');
mp19 = importdata('E:\matlab cal new\02-4_2\mp2.mat');
xj19 = importdata('E:\matlab cal new\02-4_2\xj2.mat');
mp20 = importdata('E:\matlab cal new\02-5_2\mp2.mat');
xj20 = importdata('E:\matlab cal new\02-5_2\xj2.mat');
mp04 = (mp16+mp17+mp18+mp19+mp20)/5; %材料2拟合
xj04 = (xj16+xj17+xj18+xj19+xj20)/5;

b = importdata('E:\matlab cal new\01-1_2\bx1.mat');
bx = b/2000000000;

% plot(xj1,mp1,'r-');
% hold on;
% plot(xj2,mp2,'r:');
% hold on;
% % plot(xj3,mp3,'r--');
% % hold on;
% % plot(xj4,mp4,'r*');
% % hold on;
% plot(xj5,mp5,'rx');
% hold on;
% 
% plot(xj6,mp6,'b-');
% hold on;
% plot(xj7,mp7,'b:');
% hold on;
% % plot(xj8,mp8,'b--');
% % hold on;
% plot(xj9,mp9,'b*');
% hold on;
% % plot(xj10,mp10,'bx');
% % hold on;
% 
% plot(xj11,mp11,'g-');
% hold on;
% plot(xj12,mp12,'g:');
% hold on;
% % plot(xj13,mp13,'g--');
% % hold on;
% plot(xj14,mp14,'g*');
% hold on;
% plot(xj15,mp15,'gx');
% hold on;
% 
% plot(xj16,mp16,'y-');
% hold on;
% plot(xj17,mp17,'y:');
% hold on;
% plot(xj18,mp18,'y--');
% hold on;
% % plot(xj19,mp19,'y*');
% % hold on;
% % plot(xj20,mp20,'yx');
% % hold on;

plot(xj01,mp01,'r-');
hold on;
plot(xj02,mp02,'b-');
hold on;
plot(xj03,mp03,'r--');
hold on;
plot(xj04,mp04,'b--');
hold on;
plot(xj03,bx,'k-');
hold on;

% set(gca,'color',[0,0,0]);
xlabel('x');ylabel('MP');
%legend('01','02');   % legend 会自动根据画图顺序分配图形
hold off;