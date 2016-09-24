function [ Xtrain, ytrain, caseBase] = ...
    DR(Xtrain, Xj, ytrain, yj, yJ, caseBase, yk)

% Just store if the case was bad classified
if ~isequal(yJ, yj)    
    y = unique(yk);
    n = zeros(length(y), 1);
    for iy = 1:length(y)
        n(iy) = length(find(strcmp(y{iy}, yk)));
    end
    
    %Majority class
    [~, index] = max(n);
    majorityClass = y(index);   

    if ~isequal(majorityClass, yJ)
        % Add yJ and it's goodness to CaseBase
        Xtrain = horzcat(Xtrain, Xj);
        ytrain = horzcat(ytrain, yJ);
        caseBase = vertcat(caseBase, [0.5, 0.5]);
    end
end


end

