function [ a, b ] = moveFromTo( a, b, idx )
%ADDFROMTO Summary of this function goes here
%   Detailed explanation goes here
mask = ones(1, size(a,2));
mask(idx) = 0;

b = horzcat(b,a(:,idx));
a = a(:, logical(mask));


end

