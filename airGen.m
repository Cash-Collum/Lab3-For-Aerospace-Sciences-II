
function [x_b, y_b] = airfoilGen(num, c)

m = floor(num/1000) / 100;
p = mod(floor(num/100), 10) / 10;
t = mod(num, 100) / 100;


yt = (t/0.2)*c*(0.2969*sqrt(x/c) - 0.1260*(x/c) - 0.3516*(x/c).^2 + 0.2843*(x/c).^3 - 0.1036*(x/c).^4);
dyc = zeros(length(x));


if x < p*c
    yc = m*(x/p^2)*(2*p - x/c);
    dyc = ((2*m)/p) - ((2*m*x)/p^2);
elseif x >= p*c
    yc = m*((c - x)/(1 - p)^2)*(1 + x/c - 2*p);
    dyc = (2*p*m)/(1-p^2);
end

xi = atan(dyc);

xU = x - yt*sin(xi);
xL = x + yt*sin(xi);

yU = yc + yt*cos(xi);
yL = yc - yt*cos(xi);


end
