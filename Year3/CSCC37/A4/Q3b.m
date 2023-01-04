function [rcnd] = Q3b(c)
    V = zeros(7, 7);
    
    for row = 1:7
        for col = 1:7
            V(row, col) = (row - 1 - c)^(col - 1);
        end
    end
    
    rcnd = rcond(V);
end