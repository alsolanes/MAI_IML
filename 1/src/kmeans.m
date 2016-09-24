function [tags, ps_centroids, iter] = kmeans(value_matrix, num_clusters, ...
    iteration_limit, ps_centroids)
%% Kmeans %%
% This method calculates the clusters using euclidean distance
%
% * value_matrix :: The matrix to be evaluated (samples are rows, features
% are columns)
% * num_clusters :: The number of clusters to be found
% * iteration_limit :: It's possible to stop the execution of this method
% by establishing a limit of iterations (by setting it to 0 it will run
% until converges)
% * ps_centroids :: The centroids can be presetted too, useful to test the
% method always with the same centroids
%%-------------------------------------------------------------------------



%% ASSERT PARAMETERS %%
% Assert that the number of clusters and the initalMeans number match
if nargin < 2
    error('ERROR:KMEANS', 'Too few input arguments');
end

if length(size(value_matrix)) > 2
    error('The number of dimensions of the input matrix has to be 2')
end


if exist('ps_centroids', 'var')
    sizeps_centroids = size(ps_centroids);
    if num_clusters ~= sizeps_centroids(1)
        error('The number of initialMeans and the number of clusters must be the same')
    end
end

%% GENERATE CENTERS %%
% Generate initial values
% These values are genearted in a range (rnd*(max-min))+min
if ~exist('ps_centroids',  'var')
    tmpsize = size(value_matrix);
    num_features = tmpsize(2);
    ps_centroids = zeros(num_clusters, num_features);
    for i= 1:num_clusters
        for j= 1:num_features
            mmin = min(value_matrix(j, :));
            mmax = max(value_matrix(j, :));
            ps_centroids(i, j) = (rand*(mmax-mmin))+mmin;
        end
    end
end

% Assume that each row is a sample and the columns represent the features
% of the sample

%% PRESET EXIT CONDITION VALUES %%
if ~exist('iteration_limit', 'var')
    iteration_limit = 0;
end



%% ITERATE %%
% Iterate a max
exit_condition = 0;
iter = 0;
tmpsize = size(value_matrix);
num_features = tmpsize(2);
while ~exit_condition
   
    
    % tag each sample in one of the existing classes
    tmpsize = size(value_matrix);
    num_samples = tmpsize(1);
    
    % Create a dictionary to store the tags
    tags = zeros(1, num_samples);
    for i= 1:num_samples
        tmp_D = zeros(1, num_clusters);
        tmp_sample = value_matrix(i,:);
        
        % Compute the distances betwen each sample to each centroid
        for j = 1:num_clusters
            tmp_centroid = ps_centroids(j, :);
            tmp_D(j) = sqrt(sum((tmp_sample - tmp_centroid) .^ 2));
        end
        
        [~, tmp_tag] = min(tmp_D);
        tags(1, i) = tmp_tag;
        
        %
    
        
    end
    
    distance = zeros(num_clusters, num_features);
    old_centroids = ps_centroids;
    
    %recalculate centroids
    for j = 1:num_clusters
        idx = find(tags==j);
        if isempty(idx)
            for z= 1:num_features
                mmin = min(value_matrix(z, :));
                mmax = max(value_matrix(z, :));
                ps_centroids(j, z) = (rand*(mmax-mmin))+mmin;
            end
        else
            ps_centroids(j,:) = mean(value_matrix(idx, :));
        end
        % Distance that centroid has moved
        distance(j,:) = sqrt(sum((old_centroids(j,:) - ps_centroids(j,:)) .^ 2));

    end
    
    % Check if the exit condition is accomplished
    iter = iter+1;
    if iter == iteration_limit || ...
       iter > 1 && exist('old_tags', 'var') && isempty(find(old_tags-tags));
   
        exit_condition = 1;
    end
    
    old_tags = tags;
       
end   
end