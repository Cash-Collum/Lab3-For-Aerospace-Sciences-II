function [CD_0] = intergral_CD_0(cd, c_root, c_tip, b)
b1 = -b/2;
b2 = b/2;
S = b * 0.5 * (c_root + c_tip);


c1 = @(y) c_root - ((c_root - c_tip)/0.5*b)*y;
integrand1 = @(y) cd * c1(y);


c2 = @(y) c_root + ((c_root - c_tip)/0.5*b)*y;
integrand2 = @(y) cd * c2(y);

CD_01 = integral(integrand1, b1, 0);
CD_02 = integral(integrand2, 0, b2);

CD_0 = (CD_01 + CD_02)/S;

end

