
% Purpose: Calculate coefficient of lift, coefficient of drag, and span
% efficiency factor using Pradtl Lifting Line Theory
% 
% INPUTS: span (b), cross sectional lift slope at tips (a0_t), cross
% sectional lift slope at root (a0_r), chord at tips (c_t), chord at roots (c_r)
% zero lift angle of attack at tips, (aero_t), zero lift angle of attack at roots (aero_t), geometric angle of
% attack at tips (geo_r), geometric angle of attack at roots (geo_r), and
% number of terms in fourier series (N)
%
% OUTPUTS: span efficiency factor (e), coefficient of lift (c_L),
% coefficient of induced drag (c_Di)

function [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)

theta = zeros(size(N)); % allocates space for theta values

% loop to calculate theta values
for i = 1:N
    theta(i) = (i * pi)/ (2 * N);
end


c = c_r - (c_r - c_t) .* cos(theta); % chord as function of theta
a0 = a0_r - (a0_r - a0_t) .* cos(theta); % sectional lift slope as function of theta
aero = aero_r - (aero_r - aero_t) .* cos(theta); % zero lift AoA as function of theta
geo = geo_r - (geo_r - geo_t) .* cos(theta); % geometric AoA as function of theta

% allocating space for matrix math
rhs = zeros(N,1);
LHS = zeros(N,N);

% loop calculating terms need to find A values
for i = 1:N
    for j = 1:N
        term1 = (4*b./(a0(i)*c(i))) * sin((2*j-1)*theta(i));
        term2 = (2*j-1) * sin((2*j-1)*theta(i)) ./ sin(theta(i));
        LHS(i,j) = term1 + term2;
    end
    rhs(i) = geo(i) - aero(i);
end

% calculation of A values
A = LHS\rhs;

% mean chord length
cM = (c_t + c_r)/2;
% aspect ratio
AR = b/(cM);

% coefficient of lift based on A1, pi, and Aspect Ratio
c_L = A(1) * pi * AR;

% calculating induced drag factor
step1 = 0;
for u = 2:N
    step1 = step1 + ((2*u-1) * ((A(u)/A(1))).^2);
end

% calculating induced drag coefficient
c_Di = ((c_L).^2 / (pi*AR)) * (1 + step1);

% calculating span efficiency factor
e = 1/(1+step1);

end


