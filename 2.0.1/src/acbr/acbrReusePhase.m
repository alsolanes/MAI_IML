function [ class ] = acbrReusePhase( Xk, yk, method )
    % Minimum:
    if method == 1
        class = yk(1);
            
        
    % Average:
    else
        y = unique(yk);
        n = zeros(length(y), 1);
        for iy = 1:length(y)
          n(iy) = length(find(strcmp(y{iy}, yk)));
        end
        [~, itemp] = max(n);
        class = y(itemp); 
    end


end

