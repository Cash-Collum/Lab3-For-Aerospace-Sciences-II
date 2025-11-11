
function [x_b, y_b] = airGen(num, c)

m = floor(num/1000) / 100;
p = mod(floor(num/100), 10) / 10;
t = mod(num, 100) / 100;

x = linspace(0,c,100);

yt = (t/0.2)*c*(0.2969*sqrt(x/c) - 0.1260*(x/c) - 0.3516*(x/c).^2 + 0.2843*(x/c).^3 - 0.1036*(x/c).^4);

dyc = zeros(1, length(x));
yc = zeros(1, length(x));
xi = zeros(1, length(x));

if p~=0 && m~=0

for i = 1:length(x)

if x(i) < p*c
    yc(i) = m*(x(i)/p^2)*(2*p - x(i)/c);
    dyc(i) = ((2*m)/p) - ((2*m*x(i))/c*p^2);
elseif x(i) >= p*c
    yc(i) = m*((c - x(i))/(1 - p)^2)*(1 + x(i)/c - 2*p);
    dyc(i) = (2*p*m)/(1-p^2);
end

xi(i) = atan(dyc(i));

end
end

xU = x - yt.*sin(xi);
xL = x + yt.*sin(xi);

yU = yc + yt.*cos(xi);
yL = yc - yt.*cos(xi);

x_b = [fliplr(xL) xU];
y_b = [fliplr(yL) yU];

figure;
plot(x_b, y_b, lineWidth = 1.2);
hold on
plot(x,yc, LineWidth = 1.2);
xlabel("Chord"); 
num_str = sprintf('%04d', num);
title("NACA " + num_str + " Airfoil");
legend("Airfoil Shape", "Camber Line");
grid on;

end
