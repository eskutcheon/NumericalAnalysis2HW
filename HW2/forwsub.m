% function takes a lower triangular matrix L and column vector b, solving
    % the system through forward substitution
function y = forwsub(L, b)
n = length(b);
if n ~= length(L(:,1))
    error("matrix and column vector dimensions must agree")
end
y = zeros(n,1); % preallocates vector y
L = tril(L); % makes matrix a lower triangular if it is not one already
for i = 1:n % for row entries of y, b, and L
    y(i) = b(i); % assigns b_i to y_i before any solving
    for j = 1:i-1 % stays below diagonal
        y(i) = y(i)-(L(i,j)*y(j)); % solves by substitution
    end
end