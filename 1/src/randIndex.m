function rand_index=randIndex(x,ground_truth)
% Returns the Adjusted Rand Index of two vectors.
%
%INPUTS
% two vectors x, ground_truth with x as the result of a clustering algorithm, and ground_truth
% as the ground truth vector
%
%OUTPUT
% returns a value between 0 and 1 as the quality value of a cluster

% conf_mat matrix
K = max(ground_truth);
X_len = max(x);
conf_mat=zeros(K,X_len);
for i=1:length(x)
    conf_mat(x(i),ground_truth(i))=conf_mat(x(i),ground_truth(i))+1;
end

conf_mat(K+1,:) = sum(conf_mat);
conf_mat(:,X_len+1) = sum(conf_mat,2);
a = 0;
nij_square = 0;
for i=1:K
   for j=1:X_len
       a = a + double(conf_mat(i,j)*(conf_mat(i,j)-1));
       nij_square = nij_square + double(conf_mat(i,j).^2);
   end
end
ni_square = sum(conf_mat(1:K,X_len+1).^2);
nj_square = sum(conf_mat(K+1,1:X_len).^2);
N_square = conf_mat(K+1,X_len+1).^2;


a = a/2;
b = double(nj_square - nij_square)/2;
c = double(ni_square - nij_square)/2;
d = double(N_square + nij_square - (ni_square + nj_square))/2;


rand_index = (a + d)/(a + b + c + d);

% Calculate the expected index
n=sum(sum(conf_mat));
ni_square=sum(sum(conf_mat,2).^2);		%sum of squares of sums of rows
nj_square=sum(sum(conf_mat,1).^2);		%sum of squares of sums of columns

%Expected index (for adjustment)
nc=(n*(n^2+1)-(n+1)*ni_square-(n+1)*nj_square+2*(ni_square*nj_square)/n)/(2*(n-1));

adjusted_index = (rand_index - nc) / (1 - nc);
