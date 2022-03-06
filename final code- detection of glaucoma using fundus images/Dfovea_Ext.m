function [AA1 AA2 AA3 AA4 AA5] = Dfovea_Ext(input)

input=rgb2gray(input);
input=double(input);
wd=256;
% Input   = imread('new.bmp');
Input=imresize(input,[256 256]);
[r c p]   = size(Input);
if p==3
Input =rgb2gray(Input);
end
Input   =double(Input);

Length  = r*c; 
Dataset = reshape(Input,[Length,1]);
regions=5 %k regionS
region1=zeros(Length,1);
region2=zeros(Length,1);
region3=zeros(Length,1);
region4=zeros(Length,1);
region5=zeros(Length,1);
miniv = min(min(Input));
maxiv = max(max(Input));
range = maxiv - miniv;
stepv = range/regions;
incrval = stepv;
for i = 1:regions
    K(i).centroid = incrval;
    incrval = incrval + stepv;
end

update1=0;
update2=0;
update3=0;
update4=0;
update5=0;

mean1=2;
mean2=2;
mean3=2;
mean4=2;
mean5=2;

while  ((mean1 ~= update1) & (mean2 ~= update2) & (mean3 ~= update3) & (mean4 ~= update4) & (mean5 ~= update5))

mean1=K(1).centroid;
mean2=K(2).centroid;
mean3=K(3).centroid;
mean4=K(4).centroid;
mean5=K(5).centroid;

for i=1:Length
    for j = 1:regions
        temp= Dataset(i);
        difference(j) = abs(temp-K(j).centroid);
       
    end
    [y,ind]=min(difference);
    
  if ind==1
    region1(i)   =temp;
end
if ind==2
    region2(i)   =temp;
end
if ind==3
    region3(i)   =temp;
end
if ind==4
    region4(i)   =temp;
end
if ind==5
    region5(i)   =temp;
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%UPDATE CENTROIDS
cout1=0;
cout2=0;
cout3=0;
cout4=0;
cout5=0;

for i=1:Length
    Load1=region1(i);
    Load2=region2(i);
    Load3=region3(i);
    Load4=region4(i);
    Load5=region5(i);
    
    if Load1 ~= 0
        cout1=cout1+1;
    end
    
    if Load2 ~= 0
        cout2=cout2+1;
    end
%     
    if Load3 ~= 0
        cout3=cout3+1;
    end
    
    if Load4 ~= 0
        cout4=cout4+1;
    end
    
    if Load5 ~= 0
        cout5=cout5+1;
    end
end

Mean_region(1)=sum(region1)/cout1;
Mean_region(2)=sum(region2)/cout2;
Mean_region(3)=sum(region3)/cout3;
Mean_region(4)=sum(region4)/cout4;
Mean_region(5)=sum(region5)/cout5;
%reload
for i = 1:regions
    K(i).centroid = Mean_region(i);

end

update1=K(1).centroid;
update2=K(2).centroid;
update3=K(3).centroid;
update4=K(4).centroid;
update5=K(5).centroid;

end

AA1=reshape(region1,[wd wd]);
AA2=reshape(region2,[wd wd]);
AA3=reshape(region3,[wd wd]);
AA4=reshape(region4,[wd wd]);
AA5=reshape(region5,[wd wd]);


end

