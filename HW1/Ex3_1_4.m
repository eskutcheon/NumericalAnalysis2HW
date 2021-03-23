U = 10*rand(3,3)-5;
U(2,1) = 0; U(3,1) = 0; U(3,2) = 0; % makes U upper triangular
b = 10*rand(3,1)-5;
x = ones(3,1);

for i = 3:-1:1 % starting at bottom right corner of matrix
    x(i) = b(i); % begins with single division in bottom equation
    for j = i+1:3 % doesn't run when i+1 == 4 in the first iteration
        x(i) = x(i) - U(i,j)*x(j);
    end
    x(i) = x(i)/U(i,i);
end
disp(x)
disp(U\b)