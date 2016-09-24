
%Add necessary paths
addpaths

filename = 'doc/results1.xlsx';
[A, txt] = xlsread(filename, 1, 'A:G');

numheaders = 2;
txt = txt(numheaders:size(txt,1),:);


% Get from the XSLX the data the parameters for each execution.
% Each row contains some parameters
% Normal
samples = zeros(size(A,1),1);
miss    = zeros(size(A,1),1);
accuracymin  = zeros(size(A,1),1);
accuracyavg  = zeros(size(A,1),1);

% Weighted
Wsamples = zeros(size(A,1),1);
Wmiss    = zeros(size(A,1),1);
Waccuracymin  = zeros(size(A,1),1);
Waccuracyavg  = zeros(size(A,1),1);

oldDataset = '';

for i=1:size(A,1)
    dataset = strcat('data/',txt(i,1),'.arff');
    class   = txt(i,2);
    disp(dataset);
    GLR     = A(i,1);
    reuse   = A(i,2);
    retain  = A(i,3);
    K       = A(i,4);
    times   = A(i,5);
    
    if ~isequal(dataset, oldDataset)
        [X, y] = parser_arff_file(dataset{1},class{1});
    end
    oldDataset = dataset;
    
    pt = 1;
    sst = 0;
    mmt = 0;
    Wpt = 1;
    Wsst = 0;
    Wmmt = 0;
    for j=1:times
        try
            [ss, mm] = xvalidation( ...
                1, X, y, 5, K, GLR, reuse, retain );
        catch exception
            display('cant do that');
            ss = 0; mm = 0;
        end
        try
            [Wss, Wmm] = xvalidation( ...
                2, X, y, 5, K, GLR, reuse, retain );
            
        catch exception
            display('cant do that');
            Wss = 0; Wmm = 0;
        end
        % Normal
        perc = mm/double(ss);
        pt = min(pt,perc);   
        sst = sst + ss;
        mmt = mmt + mm;
        % Weighted
        Wperc = Wmm/double(Wss);
        Wpt = min(Wpt,Wperc);   
        Wsst = Wsst + Wss;
        Wmmt = Wmmt + Wmm;
    end
    % Normal
    ptavg = mmt/double(sst);
    samples(i) = sst;
    miss(i)    = mmt;
    accuracymin(i) = pt;
    accuracyavg(i) = ptavg;
    % Weighted
    Wptavg = Wmmt/double(Wsst);
    Wsamples(i) = Wsst;
    Wmiss(i)    = Wmmt;
    Waccuracymin(i) = Wpt;
    Waccuracyavg(i) = Wptavg;
end

ww = horzcat(samples,miss,accuracymin,accuracyavg, ...
    Wsamples, Wmiss, Waccuracymin, Waccuracyavg);

xlswrite(filename,ww,1,'H:O')
