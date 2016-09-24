function [cost] = cost2(X, Y, theta)
    m = size(Y,1);
    pred = X*theta;
    err = (pred-Y);
    cost = (1./(2*m))*(err'*err);  
end
