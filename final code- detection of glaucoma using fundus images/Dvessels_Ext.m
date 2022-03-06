function U = Dvessels_Ext(inp)

A=inp;
B1 = strel('disk',2);
B2= strel('disk',6);
X=imdilate(A,B2);
X1=imerode(X,B2);
Y=imdilate(A,B1);
Y1=imerode(Y,B1);

C= X1-Y1;

[r c]=size(C);
for i=1:r
    for j=1:c
        aa=C(i,j);
        if aa > 8
            C(i,j)=200;
        end
    end
end


F=medfilt2(C,[3 3]);
U=medfilt2(F,[5 5]);

%%%%%%%%%%% Morphological thinning operation%%%%%%%%%%%%%
T =(U-(imerode(U,B1)- imerode(imcomplement(U),B1)));

U = U;
end

