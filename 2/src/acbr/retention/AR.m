function [ Xtrain, ytrain, caseBase] = AR( Xtrain, Xj, ytrain, yj, caseBase )
    Xtrain = horzcat(Xtrain, Xj);
    ytrain = horzcat(ytrain, yj);
    caseBase = vertcat(caseBase, [0.5, 0.5]);
end

