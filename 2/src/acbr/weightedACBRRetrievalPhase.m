function [ idx, cases] = weightedACBRRetrievalPhase( X, sample, K, w )
    % Calculate euc. distance for each example
    idx = euclidean(X, sample, w);
    cases = X(:,idx(1:K));
    idx = idx(1:K);
end

