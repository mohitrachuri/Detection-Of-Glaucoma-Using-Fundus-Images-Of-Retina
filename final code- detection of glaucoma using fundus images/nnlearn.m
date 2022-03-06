function nnlearn

Nsamples = 15;

for i = 1:Nsamples;
    
    a = int2str(i);
    a1 = strcat(a,'.jpg');
    cd Database
    Dinp = imread(a1);
    cd ..
     
    %%Preprocessing
    Dinp=imresize(Dinp,[512 512]);
    Image=Dinp(:,:,2);
    
    %%Vessels Extraction
    Vessel_out = Dvessels_Ext(Image);
    [AA1,AA2,AA3,AA4,AA5] = Dfovea_Ext(Dinp);  
    
    %%Feature Extraction
    [Contrast,Correlation,Energy,Homogeneity ] = GLCM(Vessel_out);
    Feat1 = [Contrast,Correlation, Energy,Homogeneity ];
    M_AA2 = mean(mean(AA2));
    E_AA2 = entropy(AA2);
    M_AA3 = mean(mean(AA3));
    E_AA3 = entropy(AA3);
    dBfeat(:,i) = [Feat1,M_AA2,E_AA2,M_AA3,E_AA3]';
    
    save dBfeat dBfeat
    display(dBfeat);

end


end

