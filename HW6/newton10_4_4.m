format long
f=@(x)(x-cos(x));
fp=@(x)(1+sin(x));

ratios = ones(1,4);
v = 1; % initial guess
for i=1:10
    v = [v (v(i)-(f(v(i))/fp(v(i))))]
end
for j=1:4
    ratios(j) = (v(j+1)/v(j))
end

% each successive error seems to be proportional to the square of the
% previous error so that it's converging quadratically to 0
ratios^2