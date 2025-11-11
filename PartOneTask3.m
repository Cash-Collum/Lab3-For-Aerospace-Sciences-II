clc;
clear;
close all;

[xb1,yb1] = airGen(0006,10,10);
[xb2,yb2] = airGen(0012,10,10);
[xb3,yb3] = airGen(0018,10,10);


Cl1 = zeros(1,21);
Cl2 = zeros(1,21);
Cl3 = zeros(1,21);

for alpha = linspace(-10,10,21)

[Cl1(alpha+11)] = Vortex_Panel(xb1,yb1,alpha);
[Cl2(alpha+11)] = Vortex_Panel(xb2,yb3,alpha);
[Cl3(alpha+11)] = Vortex_Panel(xb3,yb3,alpha);

end


alpha = linspace(-10,10,21);

figure();
subplot(2,2,1);
plot(Cl1, alpha);

subplot(2,2,2);
plot(Cl2, alpha);

subplot(2,2,3);
plot(Cl3, alpha);

subplot(2,2,4);
plot(Cl1, alpha);
plot(Cl2, alpha);
plot(Cl3, alpha);

