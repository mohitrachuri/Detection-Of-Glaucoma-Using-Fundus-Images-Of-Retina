%%%%%%%%%%%%%%%%%%% optic disc detection%%%%%%%%%%%%%%%%%%%%%
a=imread('img2.bmp');
b=imresize(a,[768 576]);
figure,
imshow(b);
title('Original image');
input=b(:,:,2);
filtered=medfilt2(input,[5 5]);
figure,
imshow(filtered);
title('Filtered image');
% B1 = strel('disk',2);
B2= strel('disk',10);
Dilated=imdilate(filtered,B2);
figure;imshow(Dilated,[]);
Eroded=imerode(Dilated,B2);
figure;imshow(Eroded,[]); 
% pixval on;
[r c]= size(Eroded);
im1=Eroded;
for i=1:r
    for j=1:c
        xx=im1(i,j);
        if xx >=200
            im1(i,j)=255;
        else
            im1(i,j)=0;
        end
    end
end
figure;imshow(im1);
    