clc;
clear all;
close all;
[filename, pathname] = uigetfile('*.jpg;*.bmp', 'Pick an Image');
 
    if isequal(filename,0) | isequal(pathname,0)
        
   warndlg('File is not selected');
       
    else
        
      a=imread(filename);
      a=imresize(a,[512 512]);
      figure(10),imshow(a);
      title('Input Image');
    end
    
R = a(:,:,1);
G = a(:,:,2);
B = a(:,:,3);

I1 = (0.3.*R)+(0.59.*G)+(0.11*B);

figure(2),imshow(I1);
title('Gray Image');
% % % Apply Morphological Process
% % % Structureing element

sel1 = strel('disk',3);   %%%%for a flat disc-shaped structuring element radious 3
I2 = imopen(I1,sel1);

figure(8),imshow(I2);
title('Imopen');

sel2 = strel('disk',8);
I3 = imclose(I2,sel2);

figure(7),imshow(I3);
title('ImClose');

I4 = I3 - I1;
% sel3 = strel('disk',12);
% J = imtophat(I4,sel3);
figure(4),imshow(I4);
title('Difference Image');
% figure(5),imshow(J);
% % % % Binarize the resultant image by thresholding
G1 = graythresh(I4);
I5 = im2bw(I4,G1);
figure(5),imshow(I5);
title('Binarize Image');
% % % % connected component analysis
% out=imfill(I5);
out = bwlabel(I5);
figure(6);imshow(out);
title('CC Analysis');