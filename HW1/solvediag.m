% Solving any diagonal system of equations will require only one arithmetic
% operations since every equation is independent of each other

function x = solvediag(A, b)
    n = size(A, 1); % for an nxn matrix A
    x = ones(n, 1); % initializes x with n entries

    for i=1:n
        x(i) = b(i)/A(i, i); % column variable == b_i/A_ii
    end
end