function [ w, b, upp, low, ba, bb ] = svm_soft_ext( x, y, lbda )
x = x';
[m, n] = size(x);
r = x(find(y==1),:);    [ma,na] = size(r);
s = x(find(y==-1),:);   [mb,nb] = size(s);
ba = 1; bb = 1;
%Penalize majority
if ma > mb
    ba = mb / ma;
else
    bb = mb / ma;
end

cvx_begin quiet
    variables w(1,n) b(1) u(1,mb) v(1,ma) 
    minimize(norm(w, 2) + lbda*(ba*sum(v) + bb*sum(u)))
    subject to
        w*r' + ones(1,ma)*b >= ones(1,ma) - v;
        w*s' + ones(1,mb)*b <= -1*ones(1,mb) + u;
        u>=0;
        v>=0;
cvx_end
upp=[];low=[];
end