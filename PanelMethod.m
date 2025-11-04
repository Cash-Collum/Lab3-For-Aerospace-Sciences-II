clc;
clear;
close all;

c = 10;
x = linspace(1,c,c);

%Naca 0018
m = 0/100;
p = 0/10;
t = 18/100;

yc = zeros(1,length(x));
dyc = zeros(1,length(x));
xi = zeros(1,length(x));

yt = (t/0.2)*c*(0.2969*sqrt(x/c) - 0.1260*(x/c) - 0.3516*(x/c).^2 + 0.2843*(x/c).^3 - 0.1036*(x/c).^4);

for x = linspace(1,c,c)
if x < p*c
    yc(x) = m.*(x./p.^2)*(2.*p - x./c);
    dyc(x) = ((2*m)/p) - ((2*m*x)/p^2);
elseif x >= p*c
    yc(x) = m*((c - x)/(1 - p)^2).*(1 + x/c - 2*p);
    dyc(x) = (2*p*m)/(1-p^2);
end

xi(x) = atan(dyc(x));
end

x = linspace(1,c,c);

xU = x - yt.*sin(xi);
xL = x + yt.*sin(xi);

yU = yc + yt.*cos(xi);
yL = yc - yt.*cos(xi);

plot(xU,yU, 'b', lineWidth=1.5); hold on;
plot(xL,yL, 'r', lineWidth=1.5);