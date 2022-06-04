
clear all;
close all;


[filename,pathname] = uigetfile('*.jpg;*.bmp','Select An Input Image');

if isequal(filename,0) || isequal(pathname,0)
    warndlg('Image is not selected');
else
    Original = imread(filename);
    figure;
    imshow(Original);
    Original = imresize(Original,[768 576]);
    
end
RGB = Original;
green = Original(:,:,2);
figure(1);
subplot(1,3,3);
imshow(green);
A = green;
[Rlo Clo] = size(green);
% % % % % % % % % % % % % % % % % % Blood Vessel Extraction
S1 = 1;
S2 = 6;

B1 = strel('disk',S1);
B2 = strel('disk',S2);

Dilation = imdilate(A,B1);
figure(2);
subplot(1,2,1);
imshow(Dilation);

Erosion = imerode(A,B2);
figure(2);
subplot(1,2,2);
imshow(Erosion,[]);

Dilation1 = imdilate(A,B2);
Erotion1 = imerode(Dilation1,B2);

Dilation2 = imdilate(A,B1);
Erotion2 = imerode(Dilation2,B1);

C1 = Erotion1 - Erotion2;
figure(3);
imshow(C1);


[r c] = size(C1);

for i=1:r
    for j=1:c
        aa=C1(i,j);
        if aa > 9.5
            C1(i,j) = 200;
        end
    end
end

figure(4);
subplot(1,2,1);
imshow(C1);

U = medfilt2(C1,[3,3]);
U = medfilt2(C1,[5,5]);
figure(4);
subplot(1,2,2);
imshow(U);

U1 = imcomplement(U);
Thinned = U - (imerode(U,B1) - imerode(U1,B2));
figure(5);
subplot(1,2,1);
imshow(Thinned);




%%%%%%%%%% Optic Disk Find...........
% % % Original(find((Original(:,:,2)>140) & (Original(:,:,1)>180)))=0;
Original(find((Original(:,:,2)>200)))=0;
figure;
imshow(Original);
imview(Original);
[r c p] = size(Original);

for i = 1:r
    for j = 1:c
       if Original(i,j,1)==0
           optic_im(i,j) = 255;
       else
           optic_im(i,j) = 0;
       end
        
    end
end

figure;
imshow(optic_im,[]);


optic_new = im2bw(optic_im);
[L num] = bwlabel(optic_new);
s  = regionprops(L, 'Area');
removed = 0;
for m = 1:num
    if ((s(m).Area<1000) || (s(m).Area>3500))
        L(find(L==m))=0;
        removed = removed + 1;
    end
end
        
figure;
imshow(L,[]);
