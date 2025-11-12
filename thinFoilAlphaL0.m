function [alphaL0] = thinFoilAlphaL0(num, c, panels)
% Purpose: using NACA Airfoil Number, identify x and y coordinates of 
% boundary conditions for given airfoil 
% Inputs: NACA Code (num), Chord length (c), Number of Panels (panels) 
% Outputs: 0 lift angle of attack

    %% Handle NACA code safely (works with or without leading zeros) 
    if isnumeric(num)
        num = sprintf('%04d', num); % pad with leading zeros if necessary
    elseif isstring(num) || ischar(num)
        num = char(num);
        if length(num) < 4
            num = pad(num, 4, 'left', '0'); % ensure 4-digit format
        end
    else
        error('Input "num" must be numeric or string.');
    end

    % Parse m, p, t from the 4-digit NACA code
    m = str2double(num(1)) / 100;    % max camber
    p = str2double(num(2)) / 10;     % position of max camber
    t = str2double(num(3:4)) / 100;  % thickness

    %% Panel spacing along chord 
    theta = linspace(0, pi, panels);
    x = (c/2) * (1 - cos(theta)); % cosine spacing (0 to c)

    % Thickness distribution (for reference)
    yt = (t/0.2) * c * (0.2969*sqrt(x/c) - 0.1260*(x/c) - 0.3516*(x/c).^2 + ...
                        0.2843*(x/c).^3 - 0.1036*(x/c).^4);

    %% Compute alpha_L=0 
    if p ~= 0 && m ~= 0
        xsplit = p * c;
        thetasplit = acos(1 - (2 * xsplit / c));

        % Mean camber line derivative dyc/dx (piecewise)
        % dyc1 = @(theta) (2*m/p^2) * (p - (c/2*(1 - cos(theta)))/c);
        dyc1 = @(theta) ((2*m)/p) - ((2*m*(c/2 * (1-cos(theta))))/c*p^2);
        % dyc2 = @(theta) (2*m/(1-p)^2) * (p - (c/2*(1 - cos(theta)))/c);
        dyc2 = (2*p*m)/(1-p^2);

        % Integrands for thin airfoil theory alpha_L=0
        int1 = @(theta) dyc1(theta) .* (cos(theta) - 1);
        int2 = @(theta) dyc2 .* (cos(theta) - 1);

        % Integrate over 0 → π
        sum1 = integral(int1, 0, thetasplit);
        sum2 = integral(int2, thetasplit, pi);

        alphaL0 = sum1 + sum2;

    else
        % Symmetric airfoil (NACA 00xx): zero camber → alpha_L=0
        alphaL0 = 0;
    end
end