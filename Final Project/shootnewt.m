function [X,Y,niter]=shootnewt(f,fy,fyp,a,b,alpha,beta,n,tol)
% Apply Newton's method to solve equation newtf = beta
% general nonlinear 2-point form y'' = f(x,y,y'), a<x<b, y(a) = alpha, y(b)
    % = beta w/ initial slope t = y'(a)
    % using initial guess t^(0) = alpha + (beta-alpha)/(b-a)
    % converges to solution s.t. |y(b,t^k)-beta| < tol

    t0 = alpha+(beta-alpha)/(b-a); % initial guess
    h = (b-a)/(n+1); % step size
    X = a+h.*(0:n+1);
    T = [t0 zeros(1,9)];
    sol = [];
    k = 1;
    while isempty(sol)
        [Y, yp] = newtf(T(k), alpha, f, fy, fyp, h, n, a);
        if abs((Y(end) - beta)) < tol
            T(k+1) = T(k) - (Y(end) - beta)/yp
            sol = T(k+1)
        else
            k = k + 1;
            T(k) = T(k-1) - (Y(end) - beta)/yp
        end
    end
    niter = k;
    

function [Y,yp]=newtf(t,alpha,f,fy,fyp,h,n,a)
% Solve system of ODEs described on p. 518 of text using
% approach given in Algorithm 13.1.2

% Store all values of y1 in vector Y that includes boundary
% values, and store final value of z1 in yp

% In here, put inner for loop and preceding statement
% from Algorithm 13.1.2


    x = a + h.*(0:n);
    Y = [alpha, zeros(1,n+1)];
    y2 = [t, zeros(1,n+1)];
    z1 = [0, zeros(1,n+1)];
    z2 = [1, zeros(1,n+1)];

    for j = 1:n+1 %rewrite with recursive functions later
        Y(j+1) = Y(j) + h*y2(j);
        y2(j+1) = y2(j) + h*f(x(j), Y(j), y2(j));
        z1(j+1) = z1(j) + h*z2(j);
        z2(j+1) = z2(j) + h*((z1(j))*fy(x(j), Y(j), y2(j)) + z2(j)*fyp(x(j), Y(j), y2(j)));
    end
    yp = z1(n+1);
    
