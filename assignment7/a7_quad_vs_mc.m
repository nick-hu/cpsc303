%{
CPSC 303 Assignment 7: Problem 2
Comparison of Quadrature (integral command) and Monte Carlo Integration
Nicholas Hu
%}

clear variables; clc; format;

diary('a7_quad_vs_mc_output.txt');

%% Part (a)

f = @(x) 4 ./ (1 + x.^2);
fprintf('integral command:\n');
for y = [1, inf]
    fprintf('f(%d) = %g\n', y, integral(f, 0, y));
end

%% Part (b)

% Apply Monte Carlo integration on [0, 1] x [0, 4]

N = 1e7;
x = rand(1, N);
y = 4 * rand(1, N);

MC_f1 = 4 * sum(y <= f(x)) / N;

fprintf('\nMonte Carlo integration:\n');
fprintf('f(1) = %g (Absolute error: %g)\n', MC_f1, abs(pi - MC_f1));

%% Part (c)

% Apply Monte Carlo integration on [0, xmax] x [0, 4]

xmax_vals = 10 .^ (0:7);
errors = zeros(1, length(xmax_vals));

for xmax = xmax_vals
    x = xmax * rand(1, N);
    y = 4 * rand(1, N);
    MC_inf = 4 * xmax * sum(y <= f(x)) / N;
    errors(log10(xmax) + 1) = abs(2*pi - MC_inf);
end

figure;
semilogx(xmax_vals, errors);
title(['Absolute error in Monte Carlo estimate of $$f(\infty)$$ ', ...
       'vs. $$x_{\mathrm{max}}$$'], 'Interpreter', 'latex');
xlabel('$$x_{\mathrm{max}}$$', 'Interpreter', 'latex');
ylabel('Absolute error');

diary off;