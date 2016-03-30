%{
CPSC 303 Assignment 8: Problem 2
Stiff ODE Solutions and Stability using ode45, ode15s, and Forward Euler
Nicholas Hu
%}

clear variables; clc; format;

du = @(t, u) 25 * (sin(u) - u + t/5);
dv = @(t, v) 25 * (cos(t) - v + t/5);
u0 = 1;
v0 = 1;

%% Part (a)

[tsol_u, usol] = ode45(du, [0, 100], u0);
[tsol_v, vsol] = ode45(dv, [0, 100], v0);

figure;
subplot(1, 2, 1);
plot(tsol_u, usol, '--', tsol_v, vsol, '-.');
title('Solutions using ode45');
xlabel('t');
ylabel('u, v');
legend('u(t)', 'v(t)');

subplot(1, 2, 2);
plot(tsol_u, usol, 'o--', tsol_v, vsol, 'o-.');
xlim([0, 1]);
title('Closeup of solutions and step points using ode45');
xlabel('t');
ylabel('u, v');
legend('u(t)', 'v(t)');

%% Part (b)

[tsol_u, usol] = ode15s(du, [0, 100], u0);
[tsol_v, vsol] = ode15s(dv, [0, 100], v0);

figure;
subplot(1, 2, 1);
plot(tsol_u, usol, '--', tsol_v, vsol, '-.');
title('Solutions using ode15s');
xlabel('t');
ylabel('u, v');
legend('u(t)', 'v(t)');

subplot(1, 2, 2);
plot(tsol_u, usol, 'o--', tsol_v, vsol, 'o-.');
xlim([0, 1]);
title('Closeup of solutions and step points using ode15s');
xlabel('t');
ylabel('u, v');
legend('u(t)', 'v(t)');

%% Part (d)

hu = 0.5 * 2 / (25 * (1 - cos(1)));
hv = 0.5 * 2 / 25;

% Solve for u(t)

tsol = 0:hu:100;
N = length(tsol);
usol = zeros(1, N);
usol(1) = u0;

for i = 1:N-1
    usol(i+1) = usol(i) + hu * du(tsol(i), usol(i));
end

figure;
subplot(2, 2, 1);
plot(tsol, usol);

title(['Solution for u(t) using forward Euler (h = ', num2str(hu), ')']);
xlabel('t');
ylabel('u');

% Solve for u(t) using smaller step size

hu = 0.04;

tsol = 0:hu:100;
N = length(tsol);
usol = zeros(1, N);
usol(1) = u0;

for i = 1:N-1
    usol(i+1) = usol(i) + hu * du(tsol(i), usol(i));
end

subplot(2, 2, 3);
plot(tsol, usol);

title(['Solution for u(t) using forward Euler (h = ', num2str(hu), ')']);
xlabel('t');
ylabel('u');

% Solve for v(t)

tsol = 0:hv:100;
N = length(tsol);
vsol = zeros(1, N);
vsol(1) = v0;

for i = 1:N-1
    vsol(i+1) = vsol(i) + hv * dv(tsol(i), vsol(i));
end

subplot(2, 2, 2);
plot(tsol, vsol);

title(['Solution for v(t) using forward Euler (h = ', num2str(hv), ')']);
xlabel('t');
ylabel('v');

% Solve for v(t) using larger step size

hv = 0.08;

tsol = 0:hv:100;
N = length(tsol);
vsol = zeros(1, N);
vsol(1) = v0;

for i = 1:N-1
    vsol(i+1) = vsol(i) + hv * dv(tsol(i), vsol(i));
end

subplot(2, 2, 4);
plot(tsol, vsol);

title(['Solution for v(t) using forward Euler (h = ', num2str(hv), ')']);
xlabel('t');
ylabel('v');
