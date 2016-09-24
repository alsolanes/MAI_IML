function [ caseBase, Xtrain, ytrain ] = ...
    acbrReviewPhase( cases, idx, caseBase, ytrain, class, goodnessLearningRate, Xtrain)
    % STEP 1: Update goodness
   
    for k=1:size(cases,2)
        kcase = cases(:,k);
        currentGoodness = caseBase(idx(k),1);
        
        % Goodness updating
        reward = double(isequal(ytrain(idx(k)), class));
        newGoodness = currentGoodness + goodnessLearningRate * (reward - currentGoodness);
        caseBase(idx(k),1) = newGoodness;
    end
    
    
    % STEP 2: Forgetting strategy
    forgetMask = ones(size(caseBase,1),1);
    forgetMask(caseBase(:,1)<caseBase(:,2)) = 0;
    forgetMask = logical(forgetMask);
    
    % Forget them!
    Xtrain = Xtrain(:,forgetMask);
    ytrain = ytrain(:,forgetMask);
    caseBase = caseBase(forgetMask,:);

end
