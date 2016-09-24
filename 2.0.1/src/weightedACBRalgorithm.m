function [ Xtrain, CM, miss ] = weightedACBRalgorithm(Xtrain, Xtest, ytrain, ytest, K, goodnessLearningRate, reuseMethod, retainStrategy)    
%% ACBR Algorithm

CM = zeros(size(Xtrain,2),2,'double');
CM = CM + 0.5;
miss = 0;

% Determine the W vector
[~, W] = relieff(Xtrain',ytrain',K);
W = W';

for j=1:size(Xtest,2)
    Xj = Xtest(:,j);

    %Retrieval Phase
    [idx, cases] = weightedACBRRetrievalPhase(Xtrain, Xj, K, W);
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

