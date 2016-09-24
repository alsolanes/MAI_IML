function out=adjustedRandIndex(x,y)
% Returns the Adjusted Rand Index of two vectors.
%
%INPUTS
% two vectors x, y with x as the result of a clustering algorithm, and y
% as the ground truth vector
%
%OUTPUT
% returns a value between 0 and 1 as the quality value of a cluster

maxA=max(x);
maxB=max(y);

% Contingence matrix
contingence=zeros(maxA,maxB);
for i=1:length(x)
    contingence(x(i),y(i))=contingence(x(i),y(i))+1;
end
sumX=sum(contingence,2);
sumY=sum(contingence,1);

combinations=nchoosek(length(x),2); %(n 2)

nij=0;
for i=1:maxA
    for j=1:maxB
        if contingence(i,j)>1
            nij = nij + nchoosek(contingence(i,j),2);
        end
    end
end


ai=0;
for i=1:maxA
    if sumX(i)>1
        ai = ai + nchoosek(sumX(i),2);
    end
end

bj=0;
for i=1:maxB
    if sumY(i)>1
        bj = bj + nchoosek(sumY(i),2);
    end
end
Index = nij;
ExpectedIndex = ai*bj/combinations;
MaxIndex = 0.5*(ai+bj);
out = (Index - ExpectedIndex) / (MaxIndex - ExpectedIndex);
