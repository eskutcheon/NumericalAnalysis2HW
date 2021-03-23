function LU = gausselim(A)
% use EROs to transform A to row echelon form
    n = size(A,1);
    m = zeros(n,n);

    for j = 1:n-1
        for i = j+1:n % using j+1 for columns ensures that it stays below the main diagonal
            m(i,j) = A(i,j)/A(j,j); % temp storage of row entries divided by diagonal entry
            % subtract mult * row j from row i
            A(i,j:n) = A(i,j:n)-m(i,j).*A(j,j:n);
        end
    end
    LU = A+m; % since m contains the subdiagonal entries of L
end