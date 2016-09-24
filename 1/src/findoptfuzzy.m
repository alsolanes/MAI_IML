function [K, arr]= findopt( data_matrix, range, opt)
%FINDOPT This method finds the optimal number of clusters in the range
%provided
%   The method uses the performance index 

P = NaN;
K = 0;
arr = zeros(range(2),1);

for z=range(1):range(2)
    tmpsize = size(data_matrix);
    num_samples = tmpsize(1);
    clear tmpsize
    [fcm_mat, centroids, ~, ~] = fcmeans(data_matrix, z, opt(1));
   


    %calculate mean samples
    meanvec = mean(data_matrix);

    p = 0;

    for i =1:z
        da = pdist2(centroids(i,:), meanvec);
        for j =1:num_samples
            db = pdist2(centroids(i,:), data_matrix(j,:));
            p= p+ (fcm_mat(j,z)^opt(1) * (db^2-da^2));
        end
    end
    arr(z) = p;
    
    if isnan(P) || p < P
        P = p;
        K = z;
    end
end



end

