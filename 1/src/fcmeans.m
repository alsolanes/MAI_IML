function [membership_matrix, centroids, iter, tags] = fcmeans(value_matrix, num_clusters, ...
    fuzzyness, epsilon, iteration_limit, membership_matrix)
%FUZZYCMEANS Summary of this function goes here
%   Detailed explanation goes here


%% ASSERT PARAMETERS %%
% Assert that the number of clusters and the initalMeans number match
if nargin < 3
    error('ERROR:KMEANS', 'Too few input arguments');
end

if length(size(value_matrix)) > 2
    error('The number of dimensions of the input matrix has to be 2')
end

if exist('fuzzyness',  'var') && fuzzyness <= 1
    error('Fuzzyness parameter has to be greater than 1')
end


if exist('centroids', 'var')
    sizecentroids = size(centroids);
    if num_clusters ~= sizecentroids(1)
        error('The number of initialMeans and the number of clusters must be the same')
    end
end

%% GENERATE MEMBERSHIP MATRIX AND CORE VARIABLES%%
% Generate initial values
% Assert that sum(mb(i,:)) = 1

tmpsize = size(value_matrix);
num_features = tmpsize(2);
num_samples = tmpsize(1);

if ~exist('membership_matrix',  'var')
    membership_matrix = zeros(num_samples, num_clusters);
    for i= 1:num_samples
        membership_matrix(i,:) = rand(1,num_clusters)';
        membership_matrix(i,:) = (membership_matrix(i,:)/sum(membership_matrix(i,:)))';
    end
end

% Assume that each row is a sample and the columns represent the features
% of the sample

%% PRESET EXIT CONDITION VALUES %%
if ~exist('iteration_limit', 'var')
    iteration_limit = 10;
end

if ~exist('fuzzyness', 'var')
    fuzzyness = 1.25;
end



if ~exist('epsilon', 'var')
    epsilon = 0.01;
end

exit_cond = 0;
centroids = zeros(num_clusters, num_features);
iter = 0;

while ~exit_cond
    iter = iter+1;
    % calculate centroids
    for i=1:num_clusters
        top =0;
        for j=1:num_samples
            top = top+ (membership_matrix(j,i)^fuzzyness) * value_matrix(j,:); 
        end
        bot = sum((membership_matrix(:,i).^fuzzyness));
        centroids(i,:) = top/bot;
    end
    

    
    D = zeros(num_samples, num_clusters);
    for i= 1:num_samples
       
        % Compute the distances betwen each sample to each centroid
        for j = 1:num_clusters
            D(i,j) = sqrt(sum((value_matrix(i,:) - centroids(j, :)) .^ 2));
        end
        %
    end
    
    %Compute the membership of each item to each centroid
    %membership_matrix = zeros(num_samples, num_clusters);
    membership_matrix_old = membership_matrix;
    for i=1:num_samples
        for j=1:num_clusters
            coef = 2/(fuzzyness-1);
            top = D(i,j);

            bot = D(i,:);
            bot = (top./bot).^coef; 
            membership_matrix(i,j) = 1 / sum(bot);
        end
    end
    
    %Check exit conditions
    dist = zeros(num_samples,1);
    for i= 1:num_samples
       
        % Calculate distances betwen Uk and Uk+1
   
        dist(i) = sqrt(sum((membership_matrix(i,:) - membership_matrix_old(i, :)) .^ 2));
       
        %
    end
    
    if max(dist) < epsilon || iter == iteration_limit
        exit_cond = 1;
    end
    



end

tags = zeros(num_samples,1);

for i=1:num_samples
    [~, tags(i)] = max(membership_matrix(i,:));
end
tags = tags';
end
