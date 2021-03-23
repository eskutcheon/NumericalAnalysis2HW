function [A, b] = gausselim(A,b)
% use EROs to transform A to row echelon form
    n = size(A,1);
    m = zeros(n,n);
    if (n ~= length(b)) % checks linear independence
        error("Matrix must be an nxn matrix and vector must have length n")
    end

    for j = 1:n-1
        for i = j+1:n % using j+1 for columns ensures that it stays below the main diagonal
            m(i,j) = A(i,j)/A(j,j); % temp storage of row entries divided by diagonal entry
            % subtract mult * row j from row i
            A(i,j:n) = A(i,j:n)-m(i,j).*A(j,j:n); 
            % since k in Algorithm 3.1.6 has the same sequence as j, used :
            b(i) = b(i)-m(i,j).*b(j);
        end
    end
    disp(b)
end