function [X,Y,niter]=shootsec(f,a,b,alpha,beta,n,tol)
% Apply secant method to solve equation secf = beta

    t0 = alpha+(beta-alpha)/(b-a); % initial guess
    T = [t0 zeros(1,9)];
    h = (b-a)/(n+1); % step size
    X = a+h.*(0:n+1);
    sol = [];
    k = 1;
    while isempty(sol)
        Y = secf(T(k), alpha, f, n, h, a);
        if (abs(Y(end)-beta)) < tol
            T(k+1) = T(k) - (Y(end) - beta)/(b-a)
            sol = T(k+1)
        else
            k = k + 1;
            T(k) = T(k-1) - (Y(end) - beta)/(b-a)
        end
    end
    niter = k;



function Y=secf(t,alpha,f,n,h,a)
% Solve system of ODEs described on p. 518 in text using approach
% given in Algorithm 13.1.2 (only first two equations for y1 and
% y2). Store all values of y1 in vector Y that includes boundary values


    x = a + h.*(0:n);
    Y = [alpha, zeros(1,n+1)];
    y2 = [t, zeros(1,n+1)];

    for j = 1:n+1 %rewrite with recursive functions later
        Y(j+1) = Y(j) + h*y2(j);
        y2(j+1) = y2(j) + h*f(x(j), Y(j), y2(j));
    end