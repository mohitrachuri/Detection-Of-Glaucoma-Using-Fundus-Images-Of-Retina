a = imread('bloodvessel .bmp');
figure(1);
subplot(1,3,1);
imshow(a);

a = imresize(a,[768 576]);
figure(1);
subplot(1,3,2);
imshow(a);

green = a(:,:,1);
figure(1);
subplot(1,3,3);
imshow(green);
A = green;

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
pixval on;

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

Filtered = medfilt2(Thinned,[2,2]);
figure(5);
subplot(1,2,2);
imshow(Thinned);

% % % % % % % % % % % % % % % % % Exudate Detection
S3 = 8;
S4 = 10;

B3 = strel('disk',S3);
B4 = strel('disk',S4);

X = imdilate(A,B3);
Y = imdilate(A,B4);

P = Y - X;
% P = imdilate(A,B4) - imdilate(A,B3);
figure(6);
imshow(P,[]);
pixval on;

alpha = 0.06;
beta = 0.52;

maximum = max(max(P));
Thresh = alpha * maximum;

[r,c] = size(P);

for i = 1 : r
    for j = 1 : c
        xx = P(i,j);        
        if xx >= Thresh
            P1(i,j) = 1;
        else 
            P1(i,j) = 0;
        end
    end
end

figure(7);
subplot(1,2,1);
imshow(P1);

P1 = medfilt2(P1);

imwrite(P,'BW.bmp');

A = P1;
figure(1),clf,colormap('gray')
subplot(131),imagesc(A),
pixval on;

x=zeros(size(A)); 
x(378,290)=1; 
% B=ones(3);
S = 4;
B = strel('disk',S);
B=[0 1 0; 1 1 1; 0 1 0];
Hc = imcomplement(P1);
Ac = ones(size(A)) - A;
% Ac = A;
k = 0; 
converged = 0;
while converged == 0 
   k = k + 1;
   subplot(132),imagesc(x);drawnow
   xnew = double(and(imdilate(x,B),Ac));
   if sum(sum(xnew - x)) == 0, converged=1; 
   else x = xnew;
      disp(['iteration # ' int2str(k)]);
   end
   pause(.5);
end
y = x + A;
subplot(133),imagesc(y);

% Y1 = imcomplement(y);
% figure(12),imshow(y);
input_green = green;
mean_intensity = mean(mean(input_green));
max_inten = max(max(input_green));

fraction = beta * max_inten;

input_green = double(input_green);
[gx,gy] = gradient(input_green);
g = sqrt((gx .^ 2) + (gy .^ 2));
figure(9);
imshow(g,[]);
pixval on;

for i = 1 : r
    for j = 1 : c
        xx = g(i,j);        
        if xx >= 15
            exudate(i,j) = 1;
        else 
            exudate(i,j) = 0;
        end
    end
end

figure(10);
imshow(exudate);
Cnt = find(exudate==1);
count = length(Cnt) - 1500;%%%%%%% 1500 for optic disk
disp(count);
highest_gradient = max(max(g));

% % % % % % % % % % % % Optic Disk Detection

return

