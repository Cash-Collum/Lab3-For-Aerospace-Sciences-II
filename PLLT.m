function [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)

close all;
a0t = a0_t; %lift slope at tip
a0r = a0_r; %lift slope at root
ct = c_t; %chord at the tip
cr = c_r; %chord at the root
aerot = aero_t; %zero lift slope at tip
aeror = aero_r; %zero lift slope at root
geot = geo_t; %Angle of attack at tip
geor = geo_r; %Angle of attack at root

theta = zeros(size(N));

for i = 1:N
    theta(i) = (i * pi)/ (2 * N);
end
c = linspace(ct,cr,N);
a0 = linspace(a0t,a0r,N);
aero = linspace(aerot,aeror,N);
geo = linspace(geot,geor,N);


A = zeros(2*N-1,1);
rhs = zeros(N,1);
LHS = zeros(N,2*N-1);

for i = 1:N
    for j = 1:N
        term1 = (4*b./(a0(theta(i))*c(theta(i)))) .* sin((2*j-1)*theta(i));
        term2 = (2*j-1) * sin((2*j-1)*theta(i)) ./ sin(theta(i));
        LHS(i,2*j-1) = term1 + term2;
    end
    rhs(i) = geo(theta(i)) - aero(theta(i));
end

A = rhs\LHS;

AR = b/c;
c_L = A(1) * pi * AR;

for u = 2:N
    step = step + (u * (A(u)/A(1)));
end

c_Di = ((c_L)^2 / (pi*AR)) * (1 + step);

e = ((c_L)^2 / (pi*AR * c_Di));


