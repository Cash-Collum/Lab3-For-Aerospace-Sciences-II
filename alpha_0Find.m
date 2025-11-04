function [alpha_0] = alpha_0Find(XB,YB, CLWant, convergence, alpha_guess)
    % define error function (difference of CL @ alpha and CLWant)
    err_fun = @(alpha) modelErrorAlpha(XB,YB,alpha, CLWant); 

    % call fmin search to minimize err_fun
    options = optimset('Display', 'iter', 'TolX', convergence);
    alpha_0 = fminsearch(err_fun, alpha_guess, options);
end

