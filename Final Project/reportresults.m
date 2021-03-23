function reportresults(method,methfname,X,Y,Yex,n,totaltime,niter)
if nargin<8
    niter=0;
end
err=norm(Yex-Y,'inf')/norm(Yex,'inf');
figure(1)
plot(X,Y,'o-')
hold on
plot(X,Yex,'rd--')
axis tight
xlabel('x')
ylabel('y(x)')
title([ method ', n=' num2str(n) ])
filename=[ methfname num2str(n) '.jpg' ];
legend('Approximate','Exact','Location','Best')
print('-djpeg',filename)
hold off
disp([ method ', n=' num2str(n) ])
if niter>0
    timeperiter=totaltime/niter;
    disp([ 'Number of iterations: ' num2str(niter) ])
    disp([ 'Time per iteration: ' num2str(timeperiter) ' seconds' ])
end
disp([ 'Total time: ' num2str(totaltime) ' seconds' ])
disp([ 'Error: ' num2str(err) ])
disp('Press ENTER to continue.')
pause
