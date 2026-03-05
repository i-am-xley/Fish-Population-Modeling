clear
clc
close all

fbrown = @(t,y) (0.65.*y.*(1-(y./8.1))) - ((1.2.*(y.^2))./(1+(y.^2)));
dirfield(fbrown, 0:2:60, 0:0.5:6)


function dirfield(f,tval,yval)
    [tm,ym] = meshgrid(tval,yval);
    dt = tval(2) - tval(1);
    dy = yval(2) - yval(1);
    fv = vectorize(f);
    if isa(f,'function_handle')
        fv = eval(fv);
    end
    yp = feval(fv,tm,ym);
    s = 1./max(1/dt,abs(yp)./dy)*0.2;
    h = ishold;
    quiver(tval,yval,s,s.*yp,0,'.b'); hold on;
    quiver(tval,yval,-s,-s.*yp,0,'.b');
    if h
        hold on
    else
        hold off
    end
    axis([tval(1)-dt/2,tval(end)+dt/2,yval(1)-dy/2,yval(end)+dy/2])
    yline(0, 'r', 'LineWidth', 2)
    yline(0.8018, 'r', 'LineWidth', 2);
    yline(1.8564, 'r', 'LineWidth', 2);
    yline(5.4418, 'r', 'LineWidth', 2);
    xlabel('Time (in Months)');
    ylabel('Brown Trout Population (in hundreds)');
    title('Direction Field for Brown Trout');
    print('BrownDirection','-dpng','-r300')
end