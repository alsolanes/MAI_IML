function [ caseBase, Xtrain, ytrain] = ...
    acbrRetentionPhase( retainStrategy, Xtrain, Xj, ytrain, yj, yJ, caseBase, cases, clss, CBj )

if retainStrategy == 1
    [ Xtrain, ytrain, caseBase] = NR( Xtrain, Xj, ytrain, yj, caseBase);

elseif retainStrategy == 2
    [ Xtrain, ytrain, caseBase] = AR( Xtrain, Xj, ytrain, yj, caseBase );

elseif retainStrategy == 3
    [ Xtrain, ytrain, caseBase] = DR( Xtrain, Xj, ytrain, yj, yJ, caseBase, clss); 

elseif retainStrategy == 4   
    [ Xtrain, ytrain, caseBase] = LE( Xtrain, Xj, ytrain, yj, yJ, caseBase, cases, clss, CBj);            
end
end
            
