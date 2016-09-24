function [tags, ps_centroids] = bisecting_kmeans(value_matrix, ...
    num_clusters, iteration_limit)
%% Bisecting k-means
% This algorithm calculates clusters by using the euclidean distance to
% the centroid
% INPUT
% value_matrix : the matrix with the data to be analyzed
% num_clusters : the number of clusters desired to obtain
% iteration_limit : stops the algorithm after the specified iterations
% OUTPUT
% tags : output values and theirs cluster
% ps_centroids: the resulting centroids
% iter : the number of iterations taken
%%

%% VALIDATE PARAMETERS %%
% Validate that the number of parameters is the correct
if nargin < 2, error('Input parameters must be 2 or more'); end;

if ~exist('iteration_limit','var')
    iteration_limit = 1000;
end

if length(size(value_matrix)) > 2
    error('The number of dimensions of the input matrix has to be 2');
end

%at this point checked initial parameters
tmpsize = size(value_matrix);
num_samples = tmpsize(1);

exit_cond = 0;
a = ones(1, num_samples); % whose the cluster of each data, sorted as value_matrix
big_cluster = 1;
clusters = [];
iteration = 0;

while ~exit_cond
    % current_data will contain the information related to the cluster that
    % is currently being analyzed
    current_data = []; %data considered in actual cluster
    current_indexes=[]; %index of the data considered in actual cluster

    %assign current data and indexes to split
    for i=1:num_samples
        if a(i)==big_cluster
            current_data = [current_data;value_matrix(i,:)];
            current_indexes=[current_indexes i];
        end
    end
    
    
    
    % SPLIT (bisect)
    % at each iteration the cluster analyzed will be replaced by 2 clusters
    % this step must be done n times, in order to pick the one with the
    % highest overall similarity
    clusters_found = [];
    for i=1:iteration_limit
        [a_temp,b_temp] = kmeans(current_data,2);
        a_sim = 0;
        b_sim = 0;
        for j=1:length(current_indexes)
            if a_temp(j)==1
                a_sim = a_sim + norm((current_data(j,:)-b_temp(1)).^2);
            elseif a_temp(j)==2
                b_sim = b_sim + norm((current_data(j,:)-b_temp(2)).^2);
            end
        end
        c1_found{i} = [a_temp];
        c2_found{i} = [b_temp];
        c3_found(i) = a_sim+b_sim; % the similarity of this solution
    end
    [~,indx_min] = min(c3_found);
    a_temp = c1_found{indx_min};
    b_temp = c2_found{indx_min};
    
    num_current_clusters = length(unique(a));
    % now, modify data_category and clusters to add the latest ones
    % the first cluster from the kmeans result will preserve the same id
    % the other one will get the first id available
    for itm=1:length(current_indexes)
        index = current_indexes(itm);
        if a_temp(itm)==1
            a(index)=big_cluster;
        elseif a_temp(itm)==2 
            a(index)=num_current_clusters+1;
        end
    end
    
    % correspondence cluster_id - cluster_value
    clusters(big_cluster,:)=b_temp(1,:);
    clusters(num_current_clusters+1,:) = b_temp(2,:);
    
    % the biggest cluster will be the one to split at this moment
    big_cluster = mode(a);

    
    if iteration >= iteration_limit || num_current_clusters >= (num_clusters-1)
        exit_cond = 1;
    end
    iteration = iteration + 1;
end

tags = a;
ps_centroids = clusters;




