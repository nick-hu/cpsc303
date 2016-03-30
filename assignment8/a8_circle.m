%{
CPSC 303 Assignment 8: Problem 1
Comparison of ODE Solving Methods (Drawing a Parametrized Circle)
Nicholas Hu
%}

clear variables; clc; format;

r = 1; % Take radius (r) = 1
c = [r, 0]; % Initial conditions

h = 0.02; % Step size
theta = 0:h:120;
N = length(theta);

%% Forward Euler

fwdEuler = zeros(2, N);
fwdEuler(:, 1) = c;

f = @(fi) [-fi(2); fi(1)]; % Derivative
for i = 1:N-1
    fwdEuler(:, i+1) = fwdEuler(:, i) + h * f(fwdEuler(:, i));
end

figure;
subplot(2, 2, 1);
plot(fwdEuler(1, :), fwdEuler(2, :)); % Outward spiral
axis(4 * [-r, r, -r, r]);
axis equal;

title('Forward Euler');
xlabel('x');
ylabel('y');

%% Backward Euler

backEuler = zeros(2, N);
backEuler(:, 1) = c;

for i = 1:N-1
    xi = backEuler(1, i);
    yi = backEuler(2, i);
    backEuler(2, i+1) = (yi + h*xi) / (1 + h^2);
    backEuler(1, i+1) = xi - h * backEuler(2, i+1);
end

subplot(2, 2, 2);
plot(backEuler(1, :), backEuler(2, :)); % Inward spiral
axis(4 * [-r, r, -r, r]);
axis equal;

title('Backward Euler');
xlabel('x');
ylabel('y');

%% Implicit trapezoidal

itrap = zeros(2, N);
itrap(:, 1) = c;

for i = 1:N-1
    xi = itrap(1, i);
    yi = itrap(2, i);
    itrap(2, i+1) = ((1 - (h^2 / 4))*yi + h*xi) / (1 + (h^2 / 4));
    itrap(1, i+1) = xi + (h/2) * (-yi - itrap(2, i+1));
end

subplot(2, 2, 3);
plot(itrap(1, :), itrap(2, :)); % Circle!
axis(4 * [-r, r, -r, r]);
axis equal;

title('Implicit trapezoidal');
xlabel('x');
ylabel('y');