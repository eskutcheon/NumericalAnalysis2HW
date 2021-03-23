% solves Ax = b using Gaussian elimination with partial pivoting
%
function x=solveaxb(A, b)
n = length(A(:, 1));
if n ~= length(A(1, :))
    error('Matrix dimensions must agree!')
end
P = 1:n; % from hints: storing permutation matrix P and tracks index swaps
for j=1:n-1
    [maxi,k] = max(abs(A(j:n, j))); % from hints: finds max entry and index
    % row p in algorithm -> add j to k to adjust index to below the diagonal
        % minus 1 because MATLAB's indexing is ridiculous
    A([j k+j-1], :) = A([k+j-1 j], :); % also from hints: swaps rows k+j-1 and j
    P([j k+j-1]) = P([k+j-1 j]); % swaps indices in permutation matrix
    if abs(A(j, j)) < (2^(-52))*norm(A) % diagonal entry cannot be nearly 0
        % uses smallest distance between double precision numbers, 2^(-52)
        error('Matrix cannot be nearly singular')
    end
    % Below is where actual Gaussian elimination is performed
    for i = j+1:n
        A(i, j) = A(i, j)/A(j, j); % multiplier
        % begins on main diagonal, unlike Gauss elimination
        A(i, j+1:n) = A(i, j+1:n)-A(i, j)*A(j, j+1:n); % j+1 so it's on diagonal
    end
end

y=forwsub(A,b(P));
x=backsub(A,y);