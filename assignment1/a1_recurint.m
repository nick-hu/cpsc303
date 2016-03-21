%{
CPSC 303 Assignment 1: Problem 3
Recursive Integration and Numerical Errors
Nicholas Hu
%}

clear variables; clc; format;

diary('a1_recurint_output.txt');

%% Part (c)

k = 10;
y0 = log((k+1) / k);

yn = y0;
for n = 1:15
    yn = 1/n - k * yn;
end

fprintf('For k = 10 and y0 = %f, y15 is %.15f\n', y0, yn);

y15 = integral(@(x) x.^15 ./ (x+k), 0, 1);

%% Part (g)

data = [(1:15).' zeros(15, 2)];

data(1, 2) = 1 - k * y0; % Fill first row with base case values
data(1, 3) = abs(data(1, 2) - integral(@(x) x ./ (x+k), 0, 1));

for n = 2:15
    data(n, 2) = 1/n - k * data(n-1, 2);
    data(n, 3) = abs(data(n, 2) - integral(@(x) x.^n ./ (x+k), 0, 1));
end

array2table(data, 'VariableNames', {'n', 'yn', 'AbsoluteError'})

%% Part (n)

y30 = 0;

yn = y30;
for n = 29:-1:15
    yn = 1/k * (1/(n+1) - yn);
end

fprintf('\nFor k = 10 and y30 = %d, y15 is %.15f\n', y30, yn);

%% Part (o)

y30_bounds = [-5.7125e10, 5.7125e10];

yn_vals = y30_bounds;
for n = 29:-1:15
    yn_vals = 1/k * (1/(n+1) - yn_vals);
end

y15_bounds = [0.99 * y15, 1.01 * y15];
fprintf('\nFor rel. error of 1%%, %.10f <= y15 <= %.10f\n', y15_bounds);
fprintf('\ty15 computed with y30 = %+g: %.10f\n', y30_bounds(1), yn_vals(1));
fprintf('\ty15 computed with y30 = %+g: %.10f\n', y30_bounds(2), yn_vals(2));

diary off;
