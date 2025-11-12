function [alphaL0] = thinFoilAlphaL0(num, c, panels)
    if isnumeric(num)
        num = sprintf('%04d', num);
    elseif isstring(num) || ischar(num)
        num = char(num);
        if length(num) < 4
            num = pad(num, 4, 'left', '0');
        end
    else
        error('Input "num" must be numeric or string.');
    end

    m = str2double(num(1)) / 100;
    p = str2double(num(2)) / 10;
    t = str2double(num(3:4)) / 100;

    theta = linspace(0, pi, panels);
    x = (c/2) * (1 - cos(theta));

    if p ~= 0 && m ~= 0
        xsplit = p * c;
        thetasplit = acos(1 - (2 * xsplit / c));

        dyc1 = @(theta) (2*m/p^2) * (p - ( (c/2)*(1 - cos(theta)) )/c);
        dyc2 = @(theta) (2*m/(1-p)^2) * (p - ( (c/2)*(1 - cos(theta)) )/c);

        int1 = @(theta) dyc1(theta) .* (cos(theta) - 1);
        int2 = @(theta) dyc2(theta) .* (cos(theta) - 1);

        sum1 = integral(int1, 0, thetasplit);
        sum2 = integral(int2, thetasplit, pi);

        alphaL0 = - (1/pi) * (sum1 + sum2);
        alphaL0 = rad2deg(alphaL0);
    else
        alphaL0 = 0;
    end
end
