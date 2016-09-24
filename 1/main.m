%% Parametrize %
clear
% About dataset...
dataset =   'iris.arff';
class_column = 'class';

% About clustering...
fuzzy_coef = 1.5;
bisecting_iteration_limit = 10;

% About optimal K calculation...
range_opt_clusters = [1, 10];
repeat_opt_clusters = 10;



%%%%%%%%%%%%%%



%% Load data from resources %%

PATH =      './res/';
database =  '';


addpath('src/')  % add path to be able to use the scripts
dataModel = arffparser('read', strcat(PATH,database,dataset));
[dataMatrix, ground_truth] = arff2matrix(dataModel, 'class');
K = size(unique(ground_truth),1);
clear dataModel PATH database dataset


%% Apply kmeans on the data %%
[km_tags, km_centroids, ~] = kmeans(dataMatrix, K);

%% Apply bisecting kmeans on data %%
[bkm_tags, bkm_centroids]= bisecting_kmeans(dataMatrix, K, ...
    bisecting_iteration_limit);

%% Fuzzy C Means %%
[fcm_matrix, fcm_centroids, ~, fcm_tags] = fcmeans(dataMatrix, K, fuzzy_coef);

%% Calculate the optimal cluster number for the dataset

% figure();
% [K1, vec1] = findoptkmeans(dataMatrix, 'kmeans', range_opt_clusters, ...
%     repeat_opt_clusters);
% plot(vec1)
% 
% figure();
% [K2, vec2] = findoptkmeans(dataMatrix, 'bisecting', range_opt_clusters, ...
%     repeat_opt_clusters, [bisecting_iteration_limit ]);
% plot(vec2(vec2~=0))
% 
% figure();
% [K3, vec3] = findoptfuzzy(dataMatrix, [1, 20], [fuzzy_coef]);
% plot(vec3);


%% Correspond classes %%

% In order to benchmark our algorithms is necessary to correspond the
% groundtruth classes.
[correspondence, centroids, gt_tags_km] = correspond(dataMatrix, ground_truth, km_centroids);
[correspondence, centroids, gt_tags_bkm] = correspond(dataMatrix, ground_truth, bkm_centroids);
[correspondence, centroids, gt_tags_fcm] = correspond(dataMatrix, ground_truth, fcm_centroids);

%% Apply clustering validation techniques
ri_index_km = randIndex(km_tags, gt_tags_km);
ari_index_km = adjustedRandIndex(km_tags, gt_tags_km);
purity_index_km = purity(km_tags, gt_tags_km);
fmeasure_km = fmeasure(km_tags, gt_tags_km);

ri_index_bkm = randIndex(bkm_tags, gt_tags_bkm);
ari_index_bkm = adjustedRandIndex(bkm_tags, gt_tags_bkm);
purity_index_bkm = purity(bkm_tags, gt_tags_bkm);
fmeasure_bkm = fmeasure(bkm_tags, gt_tags_bkm);

ri_index_fcm = randIndex(fcm_tags, gt_tags_fcm);
ari_index_fcm = adjustedRandIndex(fcm_tags, gt_tags_fcm);
purity_index_fcm = purity(fcm_tags, gt_tags_fcm);
fmeasure_fcm = fmeasure(fcm_tags, gt_tags_fcm);

%% Show figures in 2 and 3 dimensions
% - Orange circles are he DATASET CENTROIDS
% - Yellow squares are the CALCULATED CENTROIDS

showfig(dataMatrix, fcm_centroids, centroids, '2d');
showfig(dataMatrix, fcm_centroids, centroids, '3d');

%% Create confusion matrix
[G a] = confusionmat(gt_tags_fcm, fcm_tags);