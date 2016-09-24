function [ result ] = acbrRevisionPhase( testClass, clss )
    if isequal(testClass, clss)
        result = 1;
    else
        result = 0;        
    end
end

