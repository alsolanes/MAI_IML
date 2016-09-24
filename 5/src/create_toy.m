function [ ] = create_toy(dir, filename)


    if ~exist('filename','var')
        filename = 'toy_dataset';
    end
    
    if ~exist('dir','var')
        dir = '';
    end
    figure;axis([-1 1 -1 1]);hold on; i=1;
    button=1;
    while button==1 [x(i,1),x(i,2),button]=ginput(1); plot(x(i,1),x(i,2),'rx');
    i=i+1; end
    i=1;

    button=1;
    while button==1
    [y(i,1),y(i,2),button]=ginput(1);
    plot(y(i,1),y(i,2),'b.');
    i=i+1;
    end
    data=[x', y'];
    labels=[-ones(1,size(x,1)), ones(1,size(y,1))]';
    save(strcat(dir,'/',filename,'.mat'),'data','labels');
end