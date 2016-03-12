%{
CPSC 303 Assignment 6: Problem 3
Numerical Integration with Chebfun
Nicholas Hu
%}

clear variables; clc; format;

diary('a6_chebfun_output.txt');

%% Part (a)

f = @(x) x .* cos(x);
c = chebfun(f, [0, 5]);
plot(c);
roots(c)

title('$f(x) = x \cos(x)$', 'Interpreter', 'latex');

%% Part (b)

pdf = @(x) 1/sqrt(2*pi) * exp(-x.^2 / 2);

for x = [-10, 1, 10]
    cdf = sum(chebfun(pdf, [-inf, x]));
    cdf_true = normcdf(x);
    fprintf(['\ncdf(%d) =\nChebfun: %g\nPure MATLAB: %g\n', ...
             'Absolute error: %g\n'], x, cdf, cdf_true, abs(cdf - cdf_true));
end

%% Part (c)

f = @(t) exp(-t.^2 / 2);
fprintf('\n');

for x = [-10, 1, 10]
    h = x / 100;
    cdf_Simp = (1/2) + (1/sqrt(2*pi)) * ((h/3) * ... 
               (f(0) + 2 * sum(f(2*h : 2*h : x - 2*h)) + ...
                4 * sum(f(h : 2*h : x-h)) + f(x)));
    cdf = sum(chebfun(pdf, [-inf, x]));
    fprintf('\ncdf(%d) =\nSimpson''s rule: %g\nChebfun: %g\n', ...
            x, cdf_Simp, cdf);
end

%% Part (d)

fprintf('\n');

for x = [-10, 1, 10]
    h = x / 400; % MORE intervals
    cdf_Simp = (1/2) + (1/sqrt(2*pi)) * ((h/3) * ... 
               (f(0) + 2 * sum(f(2*h : 2*h : x - 2*h)) + ...
                4 * sum(f(h : 2*h : x-h)) + f(x)));
    cdf_int = integral(pdf, -inf, x, 'AbsTol', realmin); % Adaptive quadrature
    cdf = sum(chebfun(pdf, [-inf, x]));
    fprintf(['\ncdf(%d) =\nSimpson''s rule with 400 intervals: %g\n', ...
             'integral (adaptive quadrature): %g\n', ...
             'Chebfun: %g\n'], x, cdf_Simp, cdf_int, cdf);
end

diary off;