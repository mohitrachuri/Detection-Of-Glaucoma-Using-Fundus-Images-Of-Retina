function [Contrast,Correlation, Energy,Homogeneity ] = GLCM(inp)

 max_level = max(max(inp));
 min_level = min(min(inp));
 NLevels = max_level-min_level;
 
 Gmatrix = graycomatrix(inp,'NumLevels',NLevels,'GrayLimits',[min_level max_level]);
 GLCM = graycoprops(Gmatrix);
 
 Contrast = GLCM.Contrast;
 Correlation = GLCM.Correlation;
 Energy = GLCM.Energy;
 Homogeneity =  GLCM.Homogeneity;

end

