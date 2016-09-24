function [ w, aa, b, upp, low ] = svm_soft_dual( x, y, lbda)
%SVM_DUAL Summary of this function goes here
%   Detailed explanation goes here
x = x';
ct = (y*y').*(x*x');
[m, n] = size(x);
C = double(lbda);

cvx_begin quiet
    variable aa(m,1)
    maximize ((ones(1,m)*aa)-(1/2)*(aa'*ct*aa))
    subject to
        aa >= 0;
        C >= aa;
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

