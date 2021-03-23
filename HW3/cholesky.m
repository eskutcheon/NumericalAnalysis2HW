function [G, isposdef] = cholesky(A)
    dims = size(A);
    n = dims(1);
    
if(~(all(diag(A) > 0)) || n ~= dims(2) || det(A) <= 0)
    isposdef = false;
else
    isposdef = true;
end
    
% straight from algorithm 3.3.5
for j = 1:n
    A(j,j) = sqrt(A(j,j));
    for i = (j+1):n
        A(i,j) = A(i,j)/A(j,j);
        for k = (j+1):i
            A(i,k) = A(i,k)-(A(i,j)*A(k,j));
        end
    end
end
% tril extracts lower triangular part
G = tril(A);