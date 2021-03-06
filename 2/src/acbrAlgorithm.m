function [ Xtrain, CM, miss ] = acbrAlgorithm(Xtrain, Xtest, ytrain, ytest, K, goodnessLearningRate, reuseMethod, retainStrategy)    
%% ACBR Algorithm
CM = zeros(size(Xtrain,2),2,'double');
CM = CM + 0.5;
miss = 0;

for j=1:size(Xtest,2)
    Xj = Xtest(:,j);

    %Retrieval Phase
    [idx, cases] = acbrRetrievalPhase(Xtrain, Xj, K);
    Cj = ytrain(:,idx); % Get the classes from Y matrix
    CBj = CM(idx,:);
    
    %Reuse Phase
    yj = acbrReusePhase(cases, Cj, reuseMethod);  % Calculated Class
    yJ = ytest(j);                                % Original Class
    
    %Revision phase
    if ~acbrRevisionPhase( yJ, yj )
        miss = miss + 1;
    end
    
    %Review Phase
    [ CM, Xtrain, ytrain] = acbrReviewPhase( cases, idx, CM, ytrain, yJ, goodnessLearningRate, Xtrain );

    %Retention Phase
    [ CM, Xtrain, ytrain] = acbrRetentionPhase( retainStrategy, Xtrain, Xj, ytrain, yj, yJ, CM, cases, Cj, CBj);
    

    
end
end

