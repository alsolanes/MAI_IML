function [K, arr]= findoptkmeans( data_matrix, clustering_method, range, rep,opt)
%FINDOPT This method finds the optimal number of clusters in the range
%provided
%   The method uses the performance index 

P = NaN;
K = 0;
arr = zeros(range(2),1);
stack = zeros(rep,1);

for z=range(1):range(2)
    tmpsize = size(data_matrix);
    num_samples = tmpsize(1);
    clear tmpsize
    
    for h=1:10
        if strcmp(clustering_method, 'kmeans')
            [tags, centroids, ~] = kmeans(data_matrix, z);
        elseif strcmp(clustering_method, 'bisecting')
            if mod(z,2) == 1
                continue
            end
            [tags, centroids] = bisecting_kmeans(data_matrix, z, opt(1));
        end

        %Calculate the goodness mesure
        p = 0;
        for j =1:num_samples
            p = p + pdist2(centroids(tags(j),:), data_matrix(j,:))^2;

        end
        stack(h) = p;
    end
    arr(z) = mean(stack);
    
    if isnan(P) || arr(z) < P
        P = arr(z);
        K = z;
    end
end



end

