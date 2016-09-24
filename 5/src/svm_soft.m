function [ w, b, upp, low ] = svm_soft( x, y, lbda )
%SVM_SOFT Summary of this function goes here
%   Detailed explanation goes here
[n, m] = size(x);
%C = 1/(2.*double(lbda));
C = lbda;

cvx_begin quiet
    variables w(n) e(m) b(1)
    minimize (0.5*w'*w + C*sum(e))
    subject to
    y' .* ((w' * x ) + (b * ones(1,m))) >= ones(1,m) - e'
    e>=0
cvx_end

% Find support vectors
ff = ((w' * x ) + (b * ones(1,m)));
upp = find(round(ff,3)==1);
low = find(round(ff,3)==-1);


end

