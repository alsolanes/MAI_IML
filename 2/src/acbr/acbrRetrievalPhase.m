function [ idx, cases] = acbrRetrievalPhase( X, sample, K )
    % Calculate euc. distance for each example
    idx = euclidean(X, sample);
    cases = X(:,idx(1:K));
    idx = idx(1:K);
end

