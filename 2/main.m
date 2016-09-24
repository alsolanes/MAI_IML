clear
addpaths

%% 1) Load data%%


%[X, y] = parser_arff_file('data/glass.arff','type');
[X, y] = parser_arff_file('data/vehicle.arff','class');


%% 2 %%

[ reducedX, reducedY ] = RNN(X, y);
%[ reducedX, reducedY ] = CNN(X, y);

%%pwd
K =                         5;
goodnessLearningRate =      .5;
reuseMethod =               2;
retainStrategy =            3;
weighted =                  1; %No, 2 Yes

%[test_reduced, missT_reduced] = xvalidation( 1, reducedX, reducedY, 5, K, goodnessLearningRate, reuseMethod, retainStrategy );
[test_reduced, missT_reduced] = xvalidation( 2, reducedX, reducedY, 5, K, goodnessLearningRate, reuseMethod, retainStrategy );
%[test, missT] = xvalidation( X, y, 5,  K, goodnessLearningRate, reuseMethod, retainStrategy  );
%perc_reduced = missT_reduced/test_reduced;

%% 3 Evaluate results
perc_reduced = missT_reduced/test_reduced;
perc = missT/test;


