clc;
clear
close all;

for i = -5:10

ALPHA(i+6) = i;

N = 5;
b = 36;
a0_t = (2*pi); %lift slope at tip
a0_r = (2*pi); %lift slope at root
c_t = 3.583; %chord at the tip
c_r = 5.33; %chord at the root
aero_t = thinFoilAlphaL0(0012, 36, 10); %zero lift slope at tip
aero_r = thinFoilAlphaL0(2412, 36, 10); %zero lift slope at root
geo_t = ALPHA(i+6)*pi/180; %Angle of attack at tip
geo_r = (ALPHA(i+6)+2)*pi/180; %Angle of attack at root

aero_t = aero_t * pi /180;
aero_r = aero_r * pi /180;


[e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N);
c_l(i+6) = c_L;
c_di(i+6) = c_Di;
end
plot(ALPHA, c_l); hold on; grid on;
scatter(ALPHA,c_l);
xlabel("ALPHA(degrees)");
ylabel("C_L");
title("Alpha Vs Coefficient of Lift for Cesna");
%saveas(gcf,"C_lvsALpha", 'png');


cd = .01; %All values were within 5% of this value. Integral code does not work with matrix
[c_d0] = intergral_CD_0(cd,c_r,c_t,b); 

c_D = c_di + c_d0;

figure();
plot(ALPHA, c_D); grid on; hold on;
scatter(ALPHA,c_D);
xlabel("ALPHA(degrees)");
ylabel("C_D");
title("Alpha Vs Coefficient of Drag for Cesna");

W = 2500;
roALT = 17.56;
roSL = 27.45;
Thrust = W ./ ( c_l ./ c_D );

ThrustTrue = Thrust .* (roALT / roSL);
figure()
plot(ALPHA, ThrustTrue); hold on; grid on;
yline(W);
xlabel("ALPHA(degrees)");
ylabel("True Thrust [lbf]");
title("Alpha Vs Thrust for Cesna");
xlim([-5 10])

