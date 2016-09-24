function [theta, cost, hist] = grad2(X, Y, theta, alpha, num_iters)

m = size(Y,1);

hist = zeros(num_iters,2);
cost = zeros(num_iters,1);

for i=1:num_iters
    %theta(1) = theta(1)-alpha*grad_Y;
    %theta(2) = theta(2)-alpha*grad_X;
    pred = X*theta;
    
    err_x1 = (pred-Y).*X(:,1);
    err_x2 = (pred-Y).*X(:,2);
    
    theta(1) = theta(1) - alpha *(1./m) * sum(err_x1);
    theta(2) = theta(2) - alpha *(1./m) * sum(err_x2);
    
    cost(i,1) = cost2(X,Y,theta);
    hist(i,1) = theta(1);
    hist(i,2) = theta(2);
   
    
end
end