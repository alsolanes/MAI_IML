function [ reducedX, reducedY ] = RNN( X, y )
%RNN Summary of this function goes here
%   Detailed explanation goes here

tic

samples = size(X,2);

% Create the first prediction
mdl = fitcknn(X',y);
pred = predict(mdl,X');
reducedX = X;

% Iterate over all variables
for i=1:samples
    zz = size(reducedX,2);
    
    % Logical indexs to remove the candidate
    XX = ones(1,zz);
    XX(i) = 0;
    
    % Remove the candidate
    XXz = X(:,logical(XX));
    yyz = y(:,logical(XX));

    % Perform a second prediction
    mdl = fitcknn(XXz', yyz);
    pred2 = predict(mdl,X');
    
    % Check if the prediction corresponds to the original one
    if isequal(pred2(logical(XX)),pred(logical(XX)))
        reducedX = XXz;
        reducedY = yyz;
    end
end
toc

end

