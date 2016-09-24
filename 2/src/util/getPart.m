function [ Xtrain, Xtest, ytrain, ytest ] = getPart( X, y, a, b )
%GETPART Summary of this function goes here
%   get the a-th part, of a b parted data

if size(y,1) == 0
    error('Y is empty! The class name must be wrong');
end


ap = a-1;

tot_size = size(X,2);
part_size = int16(tot_size/b);
st_point = (ap*part_size)+1;
end_point = min(tot_size, st_point+part_size);

mask = zeros(1,tot_size);
mask(1,st_point:end_point) = 1;
nmask = ones(1,tot_size);
nmask(1,st_point:end_point) = 0;

mask = logical(mask);
nmask = logical(nmask);

Xtrain = X(:,nmask);
Xtest = X(:,mask);
ytrain = y(:,nmask);
ytest = y(:,mask);

end

