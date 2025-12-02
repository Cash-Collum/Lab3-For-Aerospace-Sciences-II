%% Code to calculate sectional drag coefficient
N = 16;
cl_exp = [-0.8 -0.4 0 0.4 0.8];
cd_exp = [0.018 0.011 0.01 0.0115 0.018];

[p,S] = polyfit(cl_exp,cd_exp,4);

slope = 0.1;
alpha = linspace(-5,5,N);
cl = slope * alpha;

cd = polyval(p, cl);