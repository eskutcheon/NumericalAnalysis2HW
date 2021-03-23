function [X,Y,niter]=fdnewton(f,fy,fyp,a,b,alpha,beta,n,tol)
% Use Newton's Method for solving a system of equations 
% (Algorithm 11.1.2) with functions myF (for F) and myJ 
% (for J_F) to be implemented below in this file

% At end, add boundary values to X and Y vectors, as in fdlinear.m


    h = (b-a)/(n+1); % step size
    x = a + h.*(1:n);
    Y = (((beta-alpha)/(b-a)).*(x-alpha))+alpha
    sdfijdsogn
    length(Y)
    Y_store = [Y; zeros(9, length(x))];
    size(Y_store)
    sol = [];
    k = 1;

    while isempty(sol)
        
        F = myF(x, Y_store(k,:), f, h, alpha, beta)
        J = myJ(x, Y_store(k,:), fy, fyp, h, alpha, beta)
        size(J)
        size(F)
        
        S = (J\(-1.*F'))'
        size(S)
        if sum(abs((Y_store(k,:)+S)-Y_store(k,:))) < tol
            Y_store(k+1,1:length(S)) = Y_store(k,:)+S
            sol = Y
        else
            k = k + 1;
            Y_store(k,1:length(S)) = Y_store(k-1,:)+S
        end
    end
    niter = k;



function F=myF(x,y,f,h,alpha,beta)
% Use formulas and/or code for F(y) from Example 13.2.3
% FOllowing taken from class textbook, pgs 527-528
    n = length(y); % 102 in first test case
    F = zeros(1, n); % length 102 and 202 respectively
    xi = x(2:end-1);    % length 100
    yi = y(2:end-1);    % y_i; length 100
    yi_forw = y(3:end);    % y_{i+1} %length 100
    yi_back = y(1:end-2);  % y_{i-1} %length 100
    yprime_i = (yi_forw-yi_back)/(2*h); % centered difference / secant=tangent
    F(2:n-1) = (yi_forw-(2*yi)+yi_back)/(h^2) - f(xi,yi,yprime_i); % 2nd order centered diff / 2nd derivative
    F(1) = ((y(2)-2*y(1)+alpha)/(h^2))-f(x(1), y(1), ((y(2)-alpha)/(2*h)));
    F(n) = ((beta-2*y(n)+y(n-1))/(h^2))-f(x(n), y(n), ((beta-y(n-1))/(2*h)));
    


function J=myJ(x,y,fy,fyp,h,alpha,beta)
% Use formulas for J_F(y) on p. 528 of text

% Note: in formulas, y_0 = alpha, y_{N+1} = beta
    n = length(x);
    mainJ = zeros(1,n);
    upperJ = zeros(1,n-1);
    lowerJ = zeros(1,length(2:n));
    for j=2:n-1
        mainJ = -(2/(h^2)) - fy(x(j),y(j),(y(j+1)-y(j-1))/(2*h));
        if j < n-1
            upperJ(j) = 1/(h^2) - (1/(2*h))*fyp(x(j),y(j),(y(j+1)-y(j-1))/(2*h));
        end
        if j > 1
            lowerJ(j-1) = 1/(h^2) + (1/(2*h))*fyp(x(j),y(j),(y(j+1)-y(j-1))/(2*h));
        end
    end
    J = diag(upperJ, 1) + diag(mainJ) + diag(lowerJ, -1);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        