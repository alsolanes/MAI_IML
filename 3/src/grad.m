function [theta, cost, hist] = grad(X, Y, theta, alpha, num_iters)

m = size(Y,1);
degree = size(theta,1)-1;
hist = zeros(num_iters,degree+1);
cost = zeros(num_iters,1);
X = polimat(X,degree);

theta_tmp = zeros(size(theta));
for i=1:num_iters
    pred = X*theta;    
    for j=1:degree+1
        err = (pred-Y).*X(:,j);
        theta_tmp(j) = theta(j) - alpha *(1./m) * sum(err);
    end
    theta = theta_tmp;
    cost(i,1) = cost2(X,Y,theta);
    hist(i,:) = theta;
end
end