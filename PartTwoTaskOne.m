%function [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)
N = 5;
b = 100;
a0t = 2*pi; %lift slope at tip
a0r = 2*pi; %lift slope at root
ct = 8; %chord at the tip
cr = 10; %chord at the root
aerot = 0; %zero lift slope at tip
aeror = 0; %zero lift slope at root
geot = 5*pi/180; %Angle of attack at tip
geor = 5*pi/180; %Angle of attack at root

theta = zeros(size(N));

for i = 1:N
    theta(i) = (i * pi)/ (2 * N);
end
c = linspace(ct,cr,N);
a0 = linspace(a0t,a0r,N);
aero = linspace(aerot,aeror,N);
geo = linspace(geot,geor,N);


A = zeros(N,1);
rhs = zeros(N,1);
LHS = zeros(N,N);

for i = 1:N
    for j = 1:N
        term1 = (4*b./(a0(j)*c(i))) * sin((2*j-1)*theta(i));
        term2 = (2*j-1) * sin((2*j-1)*theta(i)) ./ sin(theta(i));
        LHS(i,j) = term1 + term2;
    end
    rhs(i) = geo(i) - aero(i);
end

A = LHS\rhs;

cM = mean(c);
AR = b/(cM);
c_L = A(1) * pi * AR

step1 = 0;
for u = 2:N
    step1 = step1 + ((2*u-1) * ((A(u)/A(1))).^2);
end

c_Di = ((c_L).^2 / (pi*AR)) * (1 + step1)

e = 1/(1+step1)


