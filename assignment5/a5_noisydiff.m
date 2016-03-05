%{
CPSC 303 Assignment 5: Problem 3
Numerical Differentiation of Sine Function with Gaussian Noise
Nicholas Hu
%}

clear variables; clc; format;

%% Part (a)

h = 0.01;
x = 0:h:2*pi;

f = sin(x);
f_noisy = f + 0.01 * randn(1, length(x));

figure;
subplot(3, 1, 1);
plot(x, f, x, f_noisy);

axis([0, 2*pi, -inf, inf]);
title('$\sin(x)$ with 1\% Gaussian noise', 'Interpreter', 'latex');

%% Part (b)

dfdx = (f(3:end) - f(1:end-2)) / (2*h);
dfdx_noisy = (f_noisy(3:end) - f_noisy(1:end-2)) / (2*h);

subplot(3, 1, 2);
plot(x(2:end-1), dfdx, x(2:end-1), dfdx_noisy);

axis([0, 2*pi, -inf, inf]);
title('Numerical differentiation of $\sin(x)$ with 1\% Gaussian noise', ...
      'Interpreter', 'latex');
  
%% Part (c)

d2fdx2 = (f(3:end) - 2*f(2:end-1) + f(1:end-2)) / (h^2);
d2fdx2_noisy = (f_noisy(3:end) - 2*f_noisy(2:end-1) + f_noisy(1:end-2)) / ... 
               (h^2);
           
subplot(3, 1, 3);
plot(x(2:end-1), d2fdx2, x(2:end-1), d2fdx2_noisy);

axis([0, 2*pi, -inf, inf]);
title(['Numerical second differentiation of $\sin(x)$ ', ... 
       'with 1\% Gaussian noise'], 'Interpreter', 'latex');

