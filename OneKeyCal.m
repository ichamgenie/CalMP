cal_b;
file1 = fopen('config.csv');
data = textscan(file1,'%s%f%f%f%f%f','delimiter', ',','headerlines',1);
fclose(file1);
nameList = data{1};
[length,tmp] = size(nameList);
tic;
% matlabpool('open','local',2);
for i = 1:length
    fileFullPath = data{1}{i};
    oxindex = data{2}(i);
    pixelpcm = data{3}(i);
    range_left = data{4}(i);
    range_right = data{5}(i);
    drop_vol = data{6}(i);
    fun_cal_combine(fileFullPath, oxindex, pixelpcm, range_left, range_right, drop_vol);
end
% matlabpool close;
toc;
dingdingding()