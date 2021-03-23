function [x, niter] = newton(f, fp, x0, tol)
format long
v = [x0];
i = 1;
r = [];
while isempty(r)
    v = [v (v(i)-(f(v(i))/fp(v(i))))]; % creates
    i = i+1;
    
    if (abs(v(i)-v(i-1)) < tol)
        r = v(i);
    end
end
    x = v(i);
    niter = i
end

% This code does some very weird things if your initial guess happens to be
% the midpoint of two roots. If by chance you read this, could you explain
% why?