function [ ret ] = pca(A, dim)

%% ASSERT PARAMETERS

if nargin < 2
    error('Not enough parameters');
end

t_size = size(A);
num_samples = t_size(1);
num_components = t_size(2);
clear t_size

if num_components < dim
    error('"dim" must be smaller than the input vector dimension')
end

%% D-Dimensional Mean Vector
%
mm = mean(A);

%% Compute Covariance matrix matrix
cc = cov(A);

%% Compute eigenvalues and eigenvectors
[eigvect, eigval] = eig(cc);

% Get a vector with the eigenvalues
eigvect=sortem(eigvect,eigval);


%% Chose dim num of eigenvectors

W = eigvect(:, 1:dim);
ret = A*W;


end

