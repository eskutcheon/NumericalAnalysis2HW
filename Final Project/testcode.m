% MAT 461/561, Final Exam
% main program
% DO NOT CHANGE THIS CODE!!! (except to comment things out occasionally)

% problem 1: linear BVP
% y'' = 2y' - y + xe^x, 0 < x < 2, y(0) = 0, y(2) = -4
% exact solution: y = x^3 e^x/6 - 5xe^x/3 + 2e^x - x - 2
% p=inline('2*ones(size(x))','x');
% q=inline('-1*ones(size(x))','x');
% r=inline('x.*exp(x)-x','x');
% 
% a=0;
% b=2;
% alpha=0;
% beta=-4;
% 
% % problem 1: finite difference
% n=100;
% tic
% [X,Y]=fdlinear(p,q,r,a,b,alpha,beta,n);
% totaltime=toc;
% Yex=X.^3.*exp(X)/6 - 5*X.*exp(X)/3 + 2*exp(X) - X - 2;
% reportresults('Finite difference','fdlinear',X,Y,Yex,n,totaltime)
% 
% n=200;
% tic
% [X,Y]=fdlinear(p,q,r,a,b,alpha,beta,n);
% totaltime=toc;
% Yex=X.^3.*exp(X)/6 - 5*X.*exp(X)/3 + 2*exp(X) - X - 2;
% reportresults('Finite difference','fdlinear',X,Y,Yex,n,totaltime)

% problem 2: nonlinear BVP
% y'' = y^3 - yy', 1 < x < 2, y(1) = 1/2, y(2) = 1/3
% exact solution: y = 1/(1+x)
f=inline('y.^3 - y.*yp','x','y','yp');
fy=inline('3*y.^2-yp','x','y','yp');
fyp=inline('-y','x','y','yp');

a=1;
b=2;
alpha=1/2;
beta=1/3;

% problem 2(a): shooting with Newton's method
% n=100;
% tic
% [X,Y,niter]=shootnewt(f,fy,fyp,a,b,alpha,beta,n,1e-8);
% totaltime=toc;
% Yex=1./(X+1);
% reportresults('Shooting method (Newton)','shootnewt',X,Y,Yex,n,totaltime,niter)
% 
% n=200;
% tic
% [X,Y,niter]=shootnewt(f,fy,fyp,a,b,alpha,beta,n,1e-8);
% totaltime=toc;
% Yex=1./(X+1);
% reportresults('Shooting method (Newton)','shootnewt',X,Y,Yex,n,totaltime,niter)
% 
% % problem 2(b): shooting with Secant method
% n=100;
% tic
% [X,Y,niter]=shootsec(f,a,b,alpha,beta,n,1e-8);
% totaltime=toc;
% Yex=1./(X+1);
% reportresults('Shooting method (secant)','shootsec',X,Y,Yex,n,totaltime,niter)
% 
% n=200;
% tic
% [X,Y,niter]=shootsec(f,a,b,alpha,beta,n,1e-8);
% totaltime=toc;
% Yex=1./(X+1);
% reportresults('Shooting method (secant)','shootsec',X,Y,Yex,n,totaltime,niter)

% problem 2(c): finite difference with Newton's method
n=100;
tic
[X,Y,niter]=fdnewton(f,fy,fyp,a,b,alpha,beta,n,1e-8);
totaltime=toc;
Yex=1./(X+1);
reportresults('Finite difference (Newton)','fdnewton',X,Y,Yex,n,totaltime,niter)

n=200;
tic
[X,Y,niter]=fdnewton(f,fy,fyp,a,b,alpha,beta,n,1e-8);
totaltime=toc;
Yex=1./(X+1);
reportresults('Finite difference (Newton)','fdnewton',X,Y,Yex,n,totaltime,niter)

