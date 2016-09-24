function [ p ] = performance( data_matrix, centroids )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


k = size(centroids);
k = k(1);


tmpsize = size(data_matrix);
num_samples = tmpsize(1);
clear tmpsize
    %calculate mean samples
meanvec = mean(data_matrix);
arr = zeros(10,1);
p = 0;


for i =1:k
    da = sqrt(sum((centroids(i,:)-meanvec) .^ 2));
    for j =1:num_samples
        db = sqrt(sum((centroids(i,:) - data_matrix(j,:)) .^ 2));
        p= p+ (db-da);
    end
end
end

