function x = backsub(U, y)
n = size(U, 1); % assuming U is an n by n upper triangular matrix
x = ones(n, 1); % initializes x
U = triu(U)
disp(U)

    for i = n:-1:1 % starting at bottom right corner of matrix
        x(i) = y(i); % begins with single division in bottom equation
        for j = i+1:n % doesn't run when i+1 > n in first iteration
            % simplifies constant terms using previously found x
            x(i) = x(i) - U(i,j)*x(j);
        end
        x(i) = x(i)/U(i,i); % finds ith column vector's variable
    end
end