function [ w, X ] = polireg( x, y, degree )
%POLIREG Summary of this function goes here
%   Detailed explanation goes here

X = polimat(x,degree);
w = (X'*X)\X'*y;
end

