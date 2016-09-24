function out = cluster_evaluation(a, b, method)

if nargin < 2 || numel(a)~=numel(b)
    error('The input must be two vectors of the same size.')
elseif min(size(a))>1 || min(size(b))>1
    error('The input must be two 1 dimension vectors.')
end

switch method
    case 'adjusted'
        