function [ dataMatrix, ground_truth] = arff2matrix( dataModel, gt_class )
%ARFF2MATRIX This function gets a struct and transforms it into a matrix
% dataModel is the readed ARFF model
% gt_class (Ground truth class) is the key name of the class value
%

if ~exist('gt_class', 'var')
    gt_class = 'clase';
end


keys = fieldnames(dataModel);
dataMatrix = [];
ground_truth = {};

for idx = 1:numel(keys)
    element = keys(idx);
    element = element{1};
    if strcmp(element,gt_class)
        ground_truth = getfield(getfield(dataModel, element), 'values');
    elseif strcmp(getfield(getfield(dataModel, element), 'kind'), 'numeric')
        if size(dataMatrix) == [0 0]
            dataMatrix = getfield(getfield(dataModel, element), 'values');
        else
            dataMatrix = vertcat(dataMatrix, getfield(getfield(dataModel, element), 'values'));
        end
    end
end

dataMatrix = dataMatrix.';
ground_truth = ground_truth.';

end

