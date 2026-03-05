
clear
close all
clc
% Everything will be calculated from tnot=0 to tfinal=15
% ynot of all equations will be 1
% r is 0.65
%% Logistical Growth
%Exact solution of dy/dt = (r*(1-(y/L))*y) - h(y) with h(y)=0 and y(0)=0
%y(t) is the size of the fish pop at time t
%y is in hundreds of fish
%t is in months
%r is the intrinsic growth rate in fish/month
%L is the carrying capacity in fish
%h(y) is the amount of harvesting
time = 0:0.5:15;
%y = (L)/(1+((L/ynot)-1)*e^(-rt));
r = 0.65;
ynot = 1;
Lr = 5.4;
Lb = 8.1;
LB = 16.3;
% Calculate Data for Rainbow Trout
yrainbow = ly(Lr, r, ynot, time);
% Calculate Data for Brown Trout
ybrown = ly(Lb, r, ynot, time);
% Calculate Data for Brook Trout
ybrook = ly(LB, r, ynot, time);

% Graph Data
figure();
hold on;
plot(time, yrainbow, 'r', 'LineWidth', 2)
plot(time, ybrown,'Color', "#964B00", 'LineWidth', 2)
plot(time, ybrook, 'b', 'LineWidth', 2)
xline(6, 'Color', 'g', 'Linewidth', 2)
xlabel('Time (months)')
ylabel('Number of Fish (in hundreds)')
legend('Rainbow Trout', 'Brown Trout', 'Brook Trout', 't=6 months', 'Location', 'northwest')
title('Trout Population')
print('logistic','-dpng','-r300')
hold off;

% Identify values at t=6
rainbow6 = yrainbow(7);
brown6 = ybrown(7);
brook6 = ybrook(7);
%% Harvesting
%h(y) is a function of the number of fish in the lake
%p and q are positive real numbers representing effectiveness of fishing
%h = (p*(y^2))/(q+(y^2));

%initialize vectors
p = [1,1.5,2];
q = [1,1.5,2];
y = 0:0.5:10;

% calculate h values for all instances of p and q
h1 = hy(p(1), q(1), y);
h2 = hy(p(1), q(2), y);
h3 = hy(p(1), q(3), y);
h4 = hy(p(2), q(1), y);
h5 = hy(p(2), q(2), y);
h6 = hy(p(2), q(3), y);
h7 = hy(p(3), q(1), y);
h8 = hy(p(3), q(2), y);
h9 = hy(p(3), q(3), y);

%graph data
figure();
hold on;
plot(y, h1, 'r', 'LineWidth', 2)
plot(y, h2, 'g', 'LineWidth', 2)
plot(y, h3, 'b', 'LineWidth', 2)
plot(y, h4, 'c', 'LineWidth', 2)
plot(y, h5, 'm', 'LineWidth', 2)
plot(y, h6, 'y', 'LineWidth', 2)
plot(y, h7, 'k', 'LineWidth', 2)
plot(y, h8, 'Color', "#7E2F8E", 'LineWidth', 2)
plot(y, h9, 'Color', "#D95319", 'LineWidth', 2)
xlabel('Number of Fish (in hundreds)')
ylabel('Amount of Fish Harvested (in hundreds)')
title('Harvesting Rate')
legend('p=1, q=1', 'p=1, q=1.5', 'p=1, q=2', 'p=1.5, q=1', 'p=1.5, q=1.5', 'p=1.5, q=2','p=2, q=1', 'p=2, q=1.5', 'p=2, q=2', 'Location', 'southeast')
print('harvesting','-dpng','-r300')
hold off;

%% Equilibrium Solution
%f = (r*(1-(y/L))*y) - (p*(y^2))/(q+(y^2)) = y(t) - h(t);
yf = 0:0.5:15;
p = 1.2;
q = 1;
guess = [0 0.8 0 0.8 1.5 5 0 12];

% Calculate f for rainbow trout
fr = fy(p, q, r, yf, Lr);
zr1 = fzero(@(i) (r*(1-(i/Lr))*i) - ((p*(i^2))/(q+(i^2))), guess(1));
zr2 = fzero(@(i) (r*(1-(i/Lr))*i) - ((p*(i^2))/(q+(i^2))), guess(2));

% Calculate f for brown trout
fb = fy(p, q, r, yf, Lb);
zb1 = fzero(@(i) (r*(1-(i/Lb))*i) - ((p*(i^2))/(q+(i^2))), guess(3));
zb2 = fzero(@(i) (r*(1-(i/Lb))*i) - ((p*(i^2))/(q+(i^2))), guess(4));
zb3 = fzero(@(i) (r*(1-(i/Lb))*i) - ((p*(i^2))/(q+(i^2))), guess(5));
zb4 = fzero(@(i) (r*(1-(i/Lb))*i) - ((p*(i^2))/(q+(i^2))), guess(6));

% Calculate f for Brook trout
fB = fy(p, q, r, yf, LB);
zB1 = fzero(@(i) (r*(1-(i/LB))*i) - ((p*(i^2))/(q+(i^2))), guess(7));
zB2 = fzero(@(i) (r*(1-(i/LB))*i) - ((p*(i^2))/(q+(i^2))), guess(8));

% Graph
figure();
hold on;
grid on;
ylim([-0.5,1.5])
plot(yf, fr, 'r', 'LineWidth', 2)
plot(yf, fb,'Color', "#964B00", 'LineWidth', 2)
plot(yf, fB, 'b', 'LineWidth', 2)
legend('Rainbow Trout', 'Brown Trout', 'Brook Trout', 'Location', 'northwest')
xlabel('Fish Population (in hundreds)')
ylabel('Rate of Change of Fish Population')
title('Equilibrium Solutions')
print('equilibrium','-dpng','-r300')
hold off;

%% Direction Fields
% Direction fields are calculated in separate .m files for each species
% using the dirfield function given in Canvas

%% Euler's Method
% %dy/dt = 0.65*(1-(y/L))*y - (1.2*(y^2))/(1+y^2))
h = 0.01;
t = 0:h:60;
y0 = [0.5, 1, 2, 20];
er = zeros(size(t));
eb = zeros(size(t));
eB = zeros(size(t));
for i = 1:4
    er(1) = y0(i);
    eb(1) = y0(i);
    eB(1) = y0(i);
    for n = 1:(length(t)-1)
        ri = er(n);
        bi = eb(n);
        Bi = eB(n);
        er(n+1) = ri + (h*((0.65*ri*(1-(ri/5.4))) - ((1.2*(ri^2))/(1+(ri^2)))));
        eb(n+1) = bi + (h*((0.65*bi*(1-(bi/8.1))) - ((1.2*(bi^2))/(1+(bi^2)))));
        eB(n+1) = Bi + (h*((0.65*Bi*(1-(Bi/16.3))) - ((1.2*(Bi^2))/(1+(Bi^2)))));
    end
    figure();
    hold on;
    plot(t, er, 'r', 'LineWidth', 2)
    plot(t, eb, 'Color', "#964B00", 'LineWidth', 2)
    plot(t, eB, 'b', 'LineWidth', 2)
    legend('Rainbow Trout', 'Brown Trout', 'Brook Trout','Location','best')
    xlabel('Time (in Months)')
    ylabel('Fish Population (in hundreds of fish)')
    title(['Eulers Approximation for y0=', num2str(100*y0(i)), 'fish'])
    print(['eulers', num2str(i)],'-dpng','-r300')
    hold off;
end

%% Functions
% This function runs Equation 4 from the Project document
function [y] = ly(L, ynot, r, time)
    y = zeros(size(time));
    y(1) = ynot;
    for t = 1:length(y)
        y(t) = (L)/(1+((L/ynot)-1)*(exp(1))^(-r*time(t)));
    end
end

% This function runs Equation 2 from the Project document
function [h] = hy(p, q, y)
    h = zeros(size(y));
    for y=0:length(h)-1
        h(y+1) = (p*(y^2))/(q+(y^2));
    end
end

% This function runs Equation 3 from the Project document
function [f] = fy(p ,q, r, yf, L)
    f = zeros(size(yf));
    for i = 0:length(f)-1
        f(i+1) = (r*(1-(i/L))*i) - ((p*(i^2))/(q+(i^2)));
    end
    
end




