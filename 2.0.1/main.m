clc
clear
addpaths

%% Pick the parameters

%%%%%%%%%%%%
% External %
dbname =    2;  % 1) glass, 2)vehicles
reduction = 1;  % 0) None, 1) RNN, 2) CNN
dataparts = 5;  % Number in which the dataset will be splitted to xvalidation

%%%%%%%%%%%%
% ACBR
goodnessLearningRate =      1;
reuseMethod =               1;
retainStrategy =            2;
K =                         3;
weighted =                  1; % No, 2 Yes



%% 1) Load data

display('--Loading data--');
if dbname==1
    [X, y] = parser_arff_file('data/glass.arff','type');
else
    [X, y] = parser_arff_file('data/vehicle.arff','class');
end


%% 2) Reduction

if reduction == 1
    display('--Running Data reduction--');
    [ X, y] = RNN(X, y);
elseif reduction == 2
    display('--Running Data reduction--');
    [ X, y ] = CNN(X, y);
end


%% 3) ACBR
display('--Running ACBR--');
tic
[total, miss] = xvalidation( weighted, X, y, dataparts, K, goodnessLearningRate, reuseMethod, retainStrategy );
toc

%% 4) Results
missRate = miss/double(total);


