%{
CPSC 303 Assignment 3: Problem 3
Global vs. Piecewise Polynomial Interpolation
Nicholas Hu
%}

clear variables; clc; format;

diary('a3_global_vs_pw_output.txt');

x = [0.1, 0.15, 0.2, 0.3, 0.35, 0.5, 0.75];
y = [3.0, 1.0, 1.2, 2.1, 2.0, 2.5, 2.5];
y_alt = y;
y_alt(2) = 2.0;

%% Parts (a)-(c)

x_test = linspace(0.1, 0.75, 100);

figure;
hold on;

old_global = polyfit(x, y, 6);
p1 = plot(x_test, polyval(old_global, x_test));
plot(x, y, 'ko');

new_global = polyfit(x, y_alt, 6);
p2 = plot(x_test, polyval(new_global, x_test));
plot(x(2), y_alt(2), 'ro');

change = polyval(new_global, 0.7) - polyval(old_global, 0.7);
fprintf('The interpolant changed by %g at x = 0.7\n', abs(change));

title('Global 6th degree polynomial interpolants');
legend([p1, p2], 'Original data', 'Modified data', 'Location', 'Best');

%% Part (d)

figure;
hold on;

p1 = plot(x_test, spline(x, y, x_test));
plot(x, y, 'ko');
p2 = plot(x_test, spline(x, y_alt, x_test));
plot(x(2), y_alt(2), 'ro');

title('Cubic (not-a-knot) splines');
legend([p1, p2], 'Original data', 'Modified data', 'Location', 'Best');

figure;
hold on;

p1 = plot(x_test, pchip(x, y, x_test));
plot(x, y, 'ko');
p2 = plot(x_test, pchip(x, y_alt, x_test));
plot(x(2), y_alt(2), 'ro');

title('Piecewise cubic Hermite polynomials');
legend([p1, p2], 'Original data', 'Modified data', 'Location', 'Best');

%% Part (e)

x_mod = x([1, 3:end]);
dpdy = prod(bsxfun(@minus, 0.7, x_mod) ./ bsxfun(@minus, 0.15, x_mod));
fprintf('dp(0.7)/dy = %g\n', dpdy); 

diary off;
