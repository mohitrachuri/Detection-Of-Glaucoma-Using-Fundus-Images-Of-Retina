function selq = featselc(qfeat) 

load dfeatures;

Bfeat = [];
for i = 1:1:size(dfeatures,2)
    q = dfeatures(:,i);
    temp = sqrt(sum((qfeat - q ).^2));
    Bfeat = [Bfeat temp];
end
[relfeat , tbi] = min(Bfeat);
selq = dfeatures(:,tbi);

% Er = sort(Bfeat,'descend');
% figure;
% plot(Er);
% xlabel(' Iterations----> ');
% ylabel('Error Values--->');
% title('Performance Graph');

return;