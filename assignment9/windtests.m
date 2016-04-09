%{
CPSC 303 Assignment 9 (Capstone): Parts (j), (k), and (m)
Pollution Simulation with Convection-Diffusion PDE and Random 
(Weibull-Distributed) Wind
Nicholas Hu
%}

clear variables; clc; format;

diary('a9_windtests_output.txt');

%% Part (j)

xk = [0.5, 0.5];
N = 100;

Kpols = zeros(1, N);
for trial = 1:N
    Kpols(trial) = Kpol(wblrnd(2, 2), 2*pi*rand(), exprnd(2), exprnd(1), xk);
end

fprintf(['(Approximate) expected value of daily pollution experienced ', ... 
         'at kindergarten: %g\n'], mean(Kpols)); % Sample mean
     
%% Part (k)

fprintf('Standard deviation of samples: %g\n', ...
         std(Kpols)); % Sample standard deviation
fprintf('Standard error of expected value: %g\n', ...
         std(Kpols) / sqrt(N)); % Standard error of the mean (SEM)

%% Part (m)

% Minimize the negative of the pollution function to maximize it
Kpol1 = @(x) -Kpol(x(1), x(2), 1, 2, xk);
Kpol2 = @(x) -Kpol(x(1), x(2), 2, 1, xk);

options = optimset('Display', 'off');
worstwind = @(f, guess) fmincon(f, guess, [], [], [], [], ...
                                [0, 0], [5, 2*pi], [], options);

ww1 = worstwind(Kpol1, [0, pi - atan(0.1/0.15)]);
ww2 = worstwind(Kpol2, [0, pi/4]);

fprintf(['\nWorst wind conditions for a1 = 1, a2 = 2: ', ...
         'W = %g, theta = %g\n'], ww1(1), ww1(2));
fprintf(['Worst wind conditions for a1 = 2, a2 = 1: ', ...
         'W = %g, theta = %g\n'], ww2(1), ww2(2));
         
diary off;