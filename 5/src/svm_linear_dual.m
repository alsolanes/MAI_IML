function [ w, b, upp, low ] = svm_linear_dual( x, y)
%SVM_DUAL Summary of this function goes here
%   Detailed explanation goes here
x = x';
ct = (y*y').*(x*x');
[m, n] = size(x);

cvx_begin quiet
    variables aa(m,1)
    maximize ((ones(1,m)*aa)-(1/2)*(aa'*ct*aa)) %-sum(aa'.*y*b);
    subject to
        aa >= 0;
        y' * aa == 0;
        
cvx_end
w = (aa.*y)'*x;

sv = round(aa, 3) ~=0;
a = -(y.*(w*x')'-1)./y;
b = mean(a(sv));

ff = ((w * x' ) + (b * ones(1,m)));
upp = find(round(ff,3)==1);
low = find(round(ff,3)==-1);


end

