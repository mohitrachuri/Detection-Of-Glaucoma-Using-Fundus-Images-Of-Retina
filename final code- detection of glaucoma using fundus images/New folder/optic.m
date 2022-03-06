% % % % % % % % % % % % % % % To get Input Image
medical_input = imread('2.bmp');
figure(1);
imshow(medical_input);

% % % % % % % % % % % % Preprocessing
Original = imresize(medical_input,[300 300]);
figure(2);
subplot(1,2,1);
imshow(Original);
title('Original image');

% % % % % % % % % % % % Optic Disc Detection
% % % % % % % % % % % % Green Channel Separation
A = Original(:,:,2);
figure(2);
subplot(1,2,2);
imshow(A);
title('Green Channel');

% % % % % % % % % % % % Filtering
filtered = medfilt2(A,[5 5]);
figure(3);
imshow(filtered);
title('Filtered image');

% % % % % % % % % % Dilation
% % % % % % % % % % Structuring Elements
B2 = strel('disk',3);
Dilated = imdilate(filtered,B2);
figure(4);imshow(Dilated,[]);

% % % % % % % % % % % Erosion
% Eroded=imerode(Dilated,B2);
% figure(4);imshow(Eroded,[]); 
[r c] = size(Dilated);
im1 = Dilated;
for i = 1 : r
    for j = 1 : c
        xx = im1(i,j);
        if xx >= 150
            im1(i,j) = 255;
        else
            im1(i,j) = 0;
        end
    end
end
im1= bwareaopen(im2bw(im1),600);
figure(5);imshow(im1);
return



