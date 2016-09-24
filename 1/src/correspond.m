function [correspondence, centroids, gt_tags] = correspond(dataMatrix, ground_truth, calc_centroids)

xx = size(dataMatrix, 2);
values = unique(ground_truth);
yy = size(values, 1);

vec = zeros(size(ground_truth,1),1);
for i=1:yy
    try
        vec = vec+ (i*(ground_truth==values(i)));
    catch
        vec = vec+ (i*strcmp(ground_truth,values(i)));
    end
end


centroids = zeros(yy, xx);
correspondence = zeros(yy,2);
for i=1:yy
    %For each class, calculate the real centroid
   
    centroids(i,:) = mean(dataMatrix(vec==i,:));
    
    
    if find(isnan(centroids(i,:)))
        correspondence(i,:) = NaN;
        continue
    end
    
    correspondence(i,1) = i;
    mm = zeros(yy,1);
    for j=1:yy
        mm(j) = pdist2(centroids(i,:),calc_centroids(j,:));
    end
    [~, loc] = min(mm);
    correspondence(i,2) = loc;

end

gt_tags = zeros(size(ground_truth));
for i=1:yy
    gt_tags(vec==i) = correspondence(i,2);
end
gt_tags = gt_tags';

end