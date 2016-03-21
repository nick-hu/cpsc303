%{
CPSC 303 Assignment 1: Problem 4
The Cumulative Distribution Function (CDF)
Nicholas Hu
%}

clear variables; clc; format;

diary('a1_cdfint_output.txt');

%% Part (b)

x = 1;
if normcdf(-x) == 1 - normcdf(x)
    fprintf('normcdf(-%d) is equal to 1 - normcdf(%d)\n\n', x, x);
else
    fprintf('normcdf(-%d) is not equal to 1 - normcdf(%d)\n\n', x, x);
end

x = 10;
fprintf('normcdf(-%d) = %.15e\n', x, normcdf(-x));
fprintf('normcdf(%d) = %.15e\n', x, normcdf(x));
fprintf('1 - normcdf(%d) = %.15e\n\n', x, 1 - normcdf(x));

%% Part (d)

x = 1;
N = 20; % 21 term sum

sum = 0;
for n = 0:N
    k = 2*n + 1;
    sum = sum + (-1)^(mod(n, 2)) * x^k / (2^n * k * gamma(n+1));
end
value = 1/2 + (1 / sqrt(2*pi)) * sum;

fprintf('normcdf(%d) = %.15e, computed by loop summation\n', x, value);
fprintf('normcdf(%d) = %.15e, computed by MATLAB\n\n', x, normcdf(x));

%% Part (e)

x = 10;

sum = 0;
for n = 0:N
    k = 2*n + 1;
    sum = sum + (-1)^(mod(n, 2)) * x^k / (2^n * k * gamma(n+1));
end
value = 1/2 + (1 / sqrt(2*pi)) * sum;

fprintf('normcdf(%d) = %.15e, computed by loop summation\n', x, value);
fprintf('normcdf(%d) = %.15e, computed by MATLAB\n\n', x, normcdf(x));

diary off;
