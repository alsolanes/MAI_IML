function [ yy, pct ] = svm_test( w, b, x, y, wa, wb)
%TEST_SVM Summary of this function goes here
%   Detailed explanation goes here

fct = w*x + b;

yy = y==sign(fct)';
pct = 1-sum(yy)/double(size(x,2));

if exist('wa', 'var') && exist('wb', 'var')
    c1 = sum((y==1.*yy).*wb);
    c2 = sum((y==-1*yy)*wa);
    
    tot = sum(y==1*wb) + sum(y==1*wa);
    pct = 1-((c1+c2) / tot);
end

end
