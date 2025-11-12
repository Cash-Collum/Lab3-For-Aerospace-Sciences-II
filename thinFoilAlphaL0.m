function [alphaL0] = thinFoilAlphaL0(num, c, panels)
m = floor(num/1000) / 100;
p = mod(floor(num/100), 10) / 10;
t = mod(num, 100) / 100;

if p ~= 0 && m ~= 0
    th_split = acos(1 - 2 * p);
    th0 = 0;
    thf = pi;
    f_front = @(th) (2 * m / p^2) * (p - (1 - cos(th)) / 2) .* (cos(th) - 1);
    f_rear  = @(th) (2 * m / (1 - p)^2) * (p - (1 - cos(th)) / 2) .* (cos(th) - 1);
    int_front = integral(f_front, th0, th_split);
    int_rear  = integral(f_rear, th_split, thf);
    alphaL0 = -(1 / pi) * (int_front + int_rear);
else
    alphaL0 = 0;
end

alphaL0 = rad2deg(alphaL0);
end