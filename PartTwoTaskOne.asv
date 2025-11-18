function [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)

span = b;
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

for j = 1:N
      summ = A(2*j - 1) * sin((2j-1)* theta);
end

circulation = V*b*2 .* summ;

alpha1 = ((4*b)/ (a0 * c));

for k = 1:N
    alpha2 = A(k) * sin(k*theta(k));
    alpha3 = k * A(k) * (sin(k*theta(k)) / sin(theta(k)));
end



