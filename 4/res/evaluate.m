function [ pc_train, pc_test ] = evaluate( x, y, percent, alpha, iter, normalize )
%EVALUATE Summary of this function goes here
%   Detailed explanation goes here


ff          = int16((size(x,2)/100)*(100*percent));
x_train    = x(:,1:ff);
x_test     = x(:,ff+1:size(x,2));
y_train     = y(1:ff);
y_test      = y(ff+1:size(x,2));

clear x y


% c) Replace NaN's

x2_train = zeros(size(x_train));
x2_train(~isnan(x_train)) = x_train(~isnan(x_train));
x2_test = zeros(size(x_test));
x2_test(~isnan(x_test)) = x_test(~isnan(x_test));
for i=1:size(x_train,1)
    % Calculate means
    meanvalplus     = nanmean(x_train(i,y_train==1));
    meanvalminus    = nanmean(x_train(i,y_train==-1));
    
    % Replace NaN's by means
    x2_train(i,isnan(x_train(i,y_train==1)))    = meanvalplus;
    x2_train(i,isnan(x_train(i,y_train==-1)))   = meanvalminus;
    x2_test(i,isnan(x_test(i,y_test==1)))       = meanvalplus;
    x2_test(i,isnan(x_test(i,y_test==-1)))      = meanvalminus;
end

if normalize
    % c) Normalize the data
    mn = min(x2_train,[],2);
    mx = max(x2_train,[],2);

    for i=1:size(x2_train,1)
        x2_train(i,:) = (x2_train(i,:) - mn(i)) / (mx(i) - mn(i));
        x2_test(i,:)  = (x2_test(i,:) - mn(i)) / (mx(i) - mn(i));
    end
end

clear mn mx

[theta, X, CostHistory1] = gradientDesc(x2_train', zeros(9,1)+.5, y_train, alpha, iter);
x2_testt = vertcat(ones(1,size(x2_test,2)),x2_test);

% Analyze train data
res_train   = sign(X*theta);
diff_train  = res_train==y_train;
tot_train   = sum(diff_train);
pc_train    = tot_train/double(ff);

% Analyze test data
res_test    = sign(x2_testt'*theta);
diff_test   = res_test==y_test;
tot_test    = sum(diff_test);
pc_test     = tot_test/size(x2_test,2);

figure;
bar([pc_train, pc_test],.4);
title('Accuracy of train/test data')

% e) TODO
end

