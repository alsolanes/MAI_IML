function [ test, missT ] = xvalidation( mthd, X, y, parts, K, goodnessLearningRate, reuseMethod, retainStrategy )
%XVALIDATION Summary of this function goes here
%   Detailed explanation goes here

test = 0;
missT = 0;
for i=1:parts
    [Xtrain, Xtest, ytrain, ytest] = getPart(X, y, i, parts);
    if mthd == 1 % Normal acbr
        [~,~,miss] = acbrAlgorithm(Xtrain, Xtest, ytrain, ytest, K, goodnessLearningRate, reuseMethod, retainStrategy);
    elseif mthd == 2
        [~,~,miss] = weightedACBRalgorithm(Xtrain, Xtest, ytrain, ytest, K, goodnessLearningRate, reuseMethod, retainStrategy);
    end
    missT = missT+miss;
    test = test+size(ytest,2);
end

end

