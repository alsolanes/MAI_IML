function [ X ] = polimat( x, degree )
%POLIMAT Summary of this function goes here
%   Detailed explanation goes here
X = ones(size(x,1), degree+1);
X(:,2) = x;
for i=2:degree
    X(:,i+1) = x.^i;
end
X=fliplr(X);
end

