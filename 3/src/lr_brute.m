function [ res ] = lr_brute( x, y, range_x, range_y )
%LR_DESCENT Summary of this function goes here
%   Detailed explanation goes here

%% Generate a random point
rangex = range_x(1):range_x(2);
rangey = range_y(1):range_y(2);
res = zeros(size(rangex,2),size(rangey,2));
for i=1:size(res,1)
    w0 = rangex(i);
    for j=1:size(res,2)
        % y = w0*x+w1
        w1 = rangey(j);
        res(i,j) = (1/size(x,1))*sum(((w0*x+w1)-y).^2);

    end
end

end
