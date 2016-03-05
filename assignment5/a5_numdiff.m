%{
CPSC 303 Assignment 5: Problem 1
Numerical Differentiation with Forward and Centred Difference Formulae
Nicholas Hu
%}

clear variables; clc; format;

diary('a5_numdiff_output.txt');

%% Part (c)

x0 = 1.2;
h = 10 .^ (-20:0.5:0);

dfdx = @(x) cos(x);
forward_diff = @(x, h) (sin(x + h) - sin(x)) ./ h;
forward_diff_err = @(h) (h / 2) + (2*(eps/2) ./ h);

figure;
subplot(2, 1, 1);
loglog(h, abs(dfdx(x0) - forward_diff(x0, h)), h, forward_diff_err(h), '-.');

title(['Error in forward difference approximation to $f''(1.2)$, ', ...
       '$f(x) = \sin(x)$'], 'Interpreter', 'latex');
legend('Empirical error', 'Error bound');
xlabel('$h$', 'Interpreter', 'latex');

%% Part (e)

centred_diff = @(x, h) (sin(x+h) - sin(x-h)) ./ (2*h);
centred_diff_err = @(h) (h.^2 / 6) + ((eps/2) ./ h);

errors = abs(dfdx(x0) - centred_diff(x0, h));
h_opt = (3 * (eps/2)) ^ (1/3);

fprintf('Theoretically optimal h for centred diff. approx.: %e\n', h_opt);
fprintf('Empirically optimal h for centred diff. approx.: %e\n\n', ...
        h(errors == min(errors)));

subplot(2, 1, 2);
loglog(h, errors, h, centred_diff_err(h), '-.');

title(['Error in centred difference approximation to $f''(1.2)$, ', ...
       '$f(x) = \sin(x)$'], 'Interpreter', 'latex');
legend('Empirical error', 'Error bound');
xlabel('$h$', 'Interpreter', 'latex');

%% Part (f)

double_errors = abs(dfdx(x0) - forward_diff(x0, h));
single_errors = abs(dfdx(x0) - forward_diff(single(x0), single(h)));

fprintf('Min. err. with double precision: %e\n', min(double_errors));
fprintf('Min. err. with single precision: %e\n', min(single_errors));

figure;
loglog(h, double_errors, h, single_errors);

title(['Error in forward difference approximation to $f''(1.2)$, ', ...
       '$f(x) = \sin(x)$'], 'Interpreter', 'latex');
legend('Double precision', 'Single precision', 'Location', 'Best');
xlabel('$h$', 'Interpreter', 'latex');

diary off;