%{
CPSC 303 Assignment 8: Problem 3
Numerical Integration with ODE Solvers and Comparison with Quadrature
Methods
Nicholas Hu
%}

clear variables; clc; format;

diary('a8_integration_output.txt');

f = @(x, ~) exp(x) .* sin(100*x); % Extra argument is needed for ode45
a = 0;
b = 1;
F0 = 0;

%% Parts (b) and (c)

I_int = integral(f, a, b);
fprintf('True value:\t\t%+.15f\n', I_int);

% (i) Composite Simpson's rule (from Assignment 6: a6_compquad.m)

r = 200;
h = (b - a) / 200;
I_Simp = (h/3) * (f(a) + 2 * sum(f(a + 2*h : 2*h : b - 2*h)) + ...
                  4 * sum(f(a+h : 2*h : b-h)) + f(b));

fprintf('Comp. Simpson:\t%+.15f (Error: %.5e, fevals: %d)\n', ...
        I_Simp, abs(I_Simp - I_int), r+1);

% (ii) Forward Euler (200 steps)              

x = 0:h:1;
N = length(x);
F = zeros(1, N);
F(1) = F0;

for i = 1:N-1
    F(i+1) = F(i) + h * f(x(i));
end

fprintf('Forward Euler:\t%+.15f (Error: %.5e, fevals: %d)\n', ...
        F(end), abs(F(end) - I_int), N-1);

% (iii) ode45

sol = ode45(f, [a, b], F0);

fprintf('ode45:\t\t\t%+.15f (Error: %.5e, fevals: %d)\n', ...
        sol.y(end), abs(sol.y(end) - I_int), sol.stats.nfevals);

diary off;