function [ w, b, upp, low ] = svm_linear_primal( x, y )
%SVM_PRIMAL Summary of this function goes here
%   Detailed explanation goes here
[n, m] = size(x);

cvx_begin quiet
    variables w(n) b(1)
    minimize( 0.5*w'*w ) 
    subject to
    y' .* ((w' * x ) + (b * ones(1,m))) >= ones(1,m); 
cvx_end

%%
% Find support vectors
ff = ((w' * x ) + (b * ones(1,m)));
upp = find(round(ff,3)==1)
low = find(round(ff,3)==-1)

end

