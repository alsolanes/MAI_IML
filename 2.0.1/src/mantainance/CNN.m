function [ reducedX, reducedY] = CNN(X, y)
tic
reducedX = [];
reducedY = [];
counter = 0;
k = 1;

% Add a random point to the dataset
rd = randi(size(X,2));
[X, reducedX] = moveFromTo(X, reducedX, rd);
[y, reducedY] = moveFromTo(y, reducedY, rd);

while(counter < size(X,2)-1 && size(X,2) > 1)
    % Select a point
    Xk = X(:,k);
    
    % Calculate the distance to all other points
    idx = euclidean(reducedX,Xk);
    if ~isequal(reducedY(:, idx(1)), y(:,k))
        [X, reducedX] = moveFromTo(X, reducedX, k);
        [y, reducedY] = moveFromTo(y, reducedY, k);
        k = mod(k,size(X,2))+1;
        counter = 0;

    else
        k = mod((k+1),size(X,2))+1;
        counter = counter+1;
    end
end
toc
end