function [F, P, R] = fmeasure(x, y)
% Computes the F-measure, the precision and the recall.
%
% INPUT
% ----------
% x : array of reference values, the ground truth
% y : array of calculated values using clustering
%
% OUTPUT
% -------
% F : F-MEASURE
% P : PRECISION
% R : RECALL



true_positive = 0;
for i = 1:length(x)
    for j = 1:length(y)
        if((x(i)==y(i))&&(y(j)~=0))
            true_positive = true_positive + 1;
            y(j) = 0;
            break
        end
    end
end

false_positive = length(y)-true_positive;
false_negative = length(x)-true_positive;

P = true_positive/(true_positive+false_positive);
R = true_positive/(true_positive+false_negative);
F = 2*P*R/(P+R);
end