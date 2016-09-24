function [ Xtrain, ytrain, caseBase] = LE( Xtrain, Xj, ytrain, yj, yJ, caseBase, cases, clss, CBj )
if ~isequal(yj, yJ)
    % If the classification fails, look if there is a valid instance in the
    % cases:
    idxs = find(strcmp(clss, yJ));
    CC = cases(:,idxs);
    CB = CBj(idxs,:);
    if size(CC,2) == 0
        idxs = find(strcmp(ytrain, yJ));
        CC = Xtrain(:,idxs);
        CB = caseBase(idxs,:);
    end
    
    if size(CC,2) ~= 0
        % Calculate distances
        distances = zeros(1,size(CC,2));
        for i=1:size(CC,2)
            trainExample = CC(:,i);
            distances(i) = pdist([trainExample'; Xj'] ,'euclidean');
        end

        idx = euclidean(CC,Xj);
        ytrain = horzcat(ytrain, yJ);
        Xtrain = horzcat(Xtrain, CC(:,idx(1)));
        caseBase = vertcat(caseBase, CB((idx(1)),:));
    end

end

end

