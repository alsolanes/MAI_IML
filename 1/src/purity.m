function purity_index = purity(x,ground_truth)
% Data refers to a list of values that mean the class (id of the cluster)
% of each data value
% The purity index is the ratio between the dominant class in the cluster,
% and the size of the cluster.

K = max(ground_truth);
conf_mat = zeros(K,K,'double');


for i=1:length(ground_truth)
    conf_mat(x(i),ground_truth(i)) = conf_mat(x(i),ground_truth(i)) + 1;
end

matrix_total = sum(sum(conf_mat));
purity = 0;
total = 0;
for k=1:K
    n = sum(conf_mat(k,:));
    if(n~=0)
        total = total + n;
        cluster_purity = max(conf_mat(k,:))/n;
        purity = purity + cluster_purity*(n/matrix_total);
    end
end
purity_index = purity;