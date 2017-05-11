function StickerGenerator(InputDirectory,OutputDirectory)
% Using Matlab to generating/modifying Telegram Sticker of PNG format.
% 
%   InputDirectory: the directory path of collected picture files. 
%   OuputDirectory: the directory path of generated PNG files. 
%
%   Note: By design PNG files are lossless - there is no 'quality' to be 
%   adjusted. Thus, The size of generated/modified PNG files could be 
%   larger than 350 KB. Under the circumstance, PhotoShop would be needed.
%
%   Author:      Chouj
%   Time-stamp:  2017-05-10 15:24:45
%   URL:         http://github.com/chouj
while exist(InputDirectory)~=7
    fprintf('Invalid directory path!\n');
    InputDirectory=input('The directory path of your original pictures:','s');
end

while exist(OutputDirectory)~=7
    fprintf('Invalid directory path!\n');
    OutputDirectory=input('The absolute path of output directory:','s');
end

na=dir(InputDirectory);

for i=1:length(na)
    if na(i).isdir==0
        I=imread([InputDirectory,'\',na(i).name]);
        [height, width, dim] = size(I);
        if height>512&width>512&height>width
        J=imresize(I,[512 NaN]);
        elseif height>512&width>512&height<width
        J=imresize(I,[NaN 512]);
        elseif height>512&width<512
        J=imresize(I,[512 NaN]);
        elseif height<512&width>512
        J=imresize(I,[NaN 512]);
        elseif height<512&width<512&height<width
        J=imresize(I,[NaN 512]);
        else
        J=imresize(I,[512 NaN]);
        end
        imwrite(J,[OutputDirectory,'\',num2str(i),'.png'],'png','BitDepth',8);
    end
end

no=dir(OutputDirectory);
for i=1:length(no)
    temp1(i)=no(i).bytes/1024;
end
temp2=find(temp1>350);
if length(temp2)>1
    fprintf('Warning: These files have size larger than 350 KB:\n');
    for i=1:length(temp2)
        fprintf([no(temp2(i)).name,'\n']);
    end
elseif length(temp2)==1
    fprintf('Warning: The file below has size larger than 350 KB:\n');
    fprintf([no(temp2).name,'\n']);
else
    fprintf('Hooray: no file has size larger than 350 KB!\n');
end