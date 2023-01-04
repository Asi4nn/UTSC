function [rcnd,x0,re0,rr0,xf,ref] = badsys(n)
    A = zeros(n);
    b = zeros(n, 1);
    x = zeros(n, 1);
    
    % Populate A and b
    for i = 1:n
        for j = 1:n
            A(i, j) =  j^i;
            b(i) = b(i) + (-1)^(j+1) * A(i, j);
        end
        x(i) = (-1)^(i+1);
    end
    rcnd = rcond(A);
    xnorm = norm(x, 2);

    [L,U,P] = lu(A);

    d = mldivide(L, P * b);
    x0 = mldivide(U, d);
    re0 = norm(x0 - x, 2) / xnorm;
    rr0 = norm(b - A * x0, 2) / norm(b, 2);
    
    prev_x = x0;
    curr_x = x0;
    improvement = -1;
    
    % iterative improvement
    for iter = 1:5
        r_i = b - A * curr_x;
        d_i = mldivide(L, P * r_i);
        z_i = mldivide(U, d_i);
        temp = curr_x;
        curr_x = prev_x + z_i;
        prev_x = temp;
        
        % check if the ans is even improving
        im = norm(curr_x - prev_x, 2);
        if improvement == -1 || im < improvement
            improvement = im;
        else
            curr_x = prev_x;
            % fprintf("no improvement on iter %d\n", iter);
            break;
        end
        
        % check for subtractive cancellation
        sub = x .* curr_x;
        if any(sub < 0)
            curr_x = prev_x;
            % fprintf("sub cancellation on iter %d\n", iter);
            break;
        end
    end

    xf = curr_x;
    ref = norm(x - curr_x) / xnorm;
end