function [] = svm_draw( data, labels,  w, b,  upp, low )
%SVM_DRAW Summary of this function goes here
%   Detailed explanation goes here
if exist('upp', 'var') && exist('low','var')
    upp_ = data(:,upp);
    low_ = data(:,low);
    data(:,upp)=[];
    data(:,low)=[];
    labels(upp)=[];
    labels(low)=[];
    
    upp = upp_;
    low = low_;
end


idx = 0;
X1 = data(1,:)';
X2 = data(2,:)';

%Plot dataset points
figure
hold on
scatter(X1(labels==1),X2(labels==1), 'o', 'b');
if exist('upp','var')
    scatter(upp(1,:),upp(2,:), ones(size(upp,2),1)*200, 'o', 'b', 'filled');
end

scatter(X1(labels==-1),X2(labels==-1),'d', 'r');
if exist('low','var')
    scatter(low(1,:),low(2,:), ones(size(low,2),1)*200, 'd', 'r', 'filled');
end


xlabel('X1');
ylabel('X2');

% Plot Hyperplane
n = 100; 

cubeX1Min = min(X1(:,1));
cubeX1Max = max(X1(:,1));
 
stepx1 = (cubeX1Max-cubeX1Min)/(n-1);
[x1] = meshgrid(cubeX1Min:stepx1:cubeX1Max);
x1 = x1(1,:);

hyper = -1*w(1)/w(2)* x1 - b/w(2);
plot(x1, hyper);
idx = idx+1;

% Plot upperbound and lower bound

sv_pos = -1*w(1)/w(2)* x1 - b/w(2) +1/w(2);
sv_neg = -1*w(1)/w(2)* x1 - b/w(2) -1/w(2);

plot(x1, sv_pos);
plot(x1, sv_neg);

hold off



end

