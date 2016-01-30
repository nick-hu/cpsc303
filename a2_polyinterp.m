%{
CPSC 303 Assignment 2
Polynomial Interpolation
Nicholas Hu
%}

clear variables; clc; format;

diary('a2_polyinterp_output.txt');

%% Part (d)

x = linspace(-pi, pi, 6);
x_test = pi/4;
y_test = monomial(x, sin(2*x), x_test);

fprintf('Monomial basis gives sin(2*%f) = %.15f\n', x_test, y_test);
fprintf('The absolute error is %.15f\n', abs(sin(2*x_test) - y_test));

%% Part (e)

x_test = linspace(-pi, pi, 500);

hold on;
plot(x_test, sin(2*x_test), 'k');

for n = [2, 3, 5, 8]
    x = linspace(-pi, pi, n+1);
    plot(x_test, monomial(x, sin(2*x), x_test));
end

hold off;

title('$n$-th degree polynomial interpolants $p_n(x)$ for $f(x) = \sin(2x)$', 'Interpreter', 'latex');
xlabel('$-\pi \leq x \leq \pi$', 'Interpreter', 'latex');
ylabel('$y$', 'Interpreter', 'latex');
legend({'$f(x)$', '$p_2(x)$', '$p_3(x)$', '$p_5(x)$', '$p_8(x)$'}, 'Interpreter', 'latex');

%% Part (f)

x = linspace(-pi, pi, 6);
x_test = pi/4;
y_test = lagrange(x, sin(2*x), x_test);

fprintf('\nLagrange basis gives sin(2*%f) = %.15f\n', x_test, y_test);
fprintf('The absolute error is %.15f\n', abs(sin(2*x_test) - y_test));

%% Part (h)

warning('off', 'MATLAB:nearlySingularMatrix');
warning('off', 'MATLAB:illConditionedMatrix');

% Monomial basis "much better than" Lagrange basis
% I = [0, 1], n = 1000, x_test = 1e-4

x = linspace(0, 1, 1001);
x_test = 1e-4;

y_test_mono = monomial(x, sin(2*x), x_test);
y_test_lagr = lagrange(x, sin(2*x), x_test);

mono_err = abs(sin(2*x_test) - y_test_mono);
lagr_err = abs(sin(2*x_test) - y_test_lagr);

fprintf('\nAbsolute error with monomial basis: %.15f\n', mono_err);
fprintf('Absolute error with Lagrange basis: %.15f\n', lagr_err);
fprintf('Monomial error / Lagrange error = %f\n', mono_err / lagr_err);

% Lagrange basis "much better than" monomial basis
% I = [-1e10, 1e10], n = 24, x_test = 1e-11

x = linspace(-1e10, 1e10, 25);
x_test = 1e-11;

y_test_mono = monomial(x, sin(2*x), x_test);
y_test_lagr = lagrange(x, sin(2*x), x_test);

mono_err = abs(sin(2*x_test) - y_test_mono);
lagr_err = abs(sin(2*x_test) - y_test_lagr);

fprintf('\nAbsolute error with monomial basis: %.15f\n', mono_err);
fprintf('Absolute error with Lagrange basis: %.15f\n', lagr_err);
fprintf('Lagrange error / Monomial error = %f\n', lagr_err / mono_err);

%% Part (j)

n = 5000;
x = linspace(-pi, pi, n+1);
x_test = pi/4;

tic;
monomial(x, sin(2*x), x_test);
mono_time = toc;

tic;
lagrange(x, sin(2*x), x_test);
lagr_time = toc;

fprintf('\nRunning time for monomial with n = %d: %f seconds\n', n, mono_time);
fprintf('Running time for Lagrange with n = %d: %f seconds\n', n, lagr_time);

diary off;