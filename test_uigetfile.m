% [FileName,PathName] = uigetfile('*.avi','ѡ����Ƶ�ļ�');
% if exist('nXmin')&&exist('nXmax')
%     def1 = num2str(nXmin);
%     def2 = num2str(nXmax);
% else
%     def1 = '1';
%     def2 = '720';
% end
% value_i = inputdlg({'��߽�','�ұ߽�'},'���ұ߽��趨',1,{def1,def2});

h=waitbar(0,'pleas wait...');

for i=1:10000

waitbar(i/10000,h)

end

close(h)