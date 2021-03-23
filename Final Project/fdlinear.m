function [X,Y]=fdlinear(p,q,r,a,b,alpha,beta,n)
% Set up matrix A and vector R using formulas on p. 524 of text.
% Solve system AY = R and add boundary values alpha and beta.
format long;
R = zeros(1,n);


h = (b-a)/(n+1);
% Need vector of equally-spaced x-values in (a,b)
% This vector contains n values, NOT including boundary points a,b
% x_i = i*h, h=(b-a)/(n+1), i = 1, 2, ..., n
X = h.*(1:n); % doesn't include i=0 or i=n+1 so a and b aren't included
upperA = -1 + (h/2).*p((X(1:n-1)));
mainA = 2 + (h^2).*q(X(1:n));
lowerA = -1 - (h/2).*p(X(2:n));
R(2:n-1) = -(h^2).*r(X(2:n-1));

% A = diag(upperA, 1) + diag(mainA) + diag(lowerA, -1);
% reference: https://www.mathworks.com/help/matlab/ref/diag.html



% Evaluate p,q,r at x to get values for A, R
R(1) = -(h^2)*r(X(1)) + alpha*(1+(((h^2)/2)*p(X(1))));
R(n)= -(h^2)*r(X(n)) + beta*(1-(((h^2)/2)*p(X(n))));


% Define R = -h^2 r(x_i) first
% Then, change R(1), R(n) according to formulas in notes

% Solve system AY=R
% X and solution Y has ONLY interior values

for j = 1:n-1
    lowerA(j) = lowerA(j)/mainA(j);
    mainA(j+1) = mainA(j+1) - (lowerA(j)*upperA(j));
end


for fs = 2:n
    R(fs) = R(fs)-(lowerA(fs-1)*R(fs-1));
end
Y(n) = R(n)/mainA(n);
for bs = (n-1):-1:1
    Y(bs) = (R(bs) - (upperA(bs)*Y(bs+1)))/mainA(bs);
end


X = X';
% To add boundary values:
X = [ a; X; b ]; % assume X already has interior values
% Do the same for Y, to add alpha and beta on boundaries
Y = [alpha; Y'; beta];















