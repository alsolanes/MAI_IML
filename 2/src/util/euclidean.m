function [ idx ] = euclidean( X, sample, W )
% EUCLIDEAN DIST
% This function get as input an array
if ~exist('W','var')
    W=ones(size(X,1),1);
end

sample = sample.*W;
distances = zeros(size(X,2), 1, 'double');
for i=1:size(X,2)
   trainExample = X(:,i).*W;
   distances(i) = pdist([trainExample'; sample'] ,'euclidean');
end
[~, idx] = sort(distances);
end

