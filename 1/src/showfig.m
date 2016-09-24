function [] = showfig( dataMatrix, calc_centroids, centroids, mode)

figure()

tot = vertcat(dataMatrix, centroids, calc_centroids);

if strcmp(mode, '2d')
    ret = pca(tot, 2);
    xx = size(tot,1);
    yy = size(calc_centroids,1);
    zz = size(centroids, 1);
    expr = 1:(xx-(yy+zz));
    scatter(ret(expr,1), ret(expr,2),'.');
    expr = (xx-(yy+zz))+1:(xx-zz);
    hold on;
    scatter(ret(expr,1), ret(expr,2), 200, 'o','filled');
    expr = (xx-zz)+1:xx;
    scatter(ret(expr,1), ret(expr,2),200,'s','filled');
elseif strcmp(mode,'3d')
    ret = pca(tot, 3);
    xx = size(tot,1);
    yy = size(calc_centroids,1);
    zz = size(centroids, 1);
    expr = 1:(xx-(yy+zz));
    scatter3(ret(expr,1), ret(expr,2),ret(expr,3),'.');
    expr = (xx-(yy+zz))+1:(xx-zz);
    hold on;
    scatter3(ret(expr,1), ret(expr,2), ret(expr,3), 200, 'o','filled');
    expr = (xx-zz)+1:xx;
    scatter3(ret(expr,1), ret(expr,2), ret(expr,3), 200,'s','filled');
end

end

