%{
CPSC 303 Assignment 7: Problem 1
Approximation of Pi by Monte Carlo Integration
Nicholas Hu
%}

clear variables; clc; format;

%% Part (a)

N = 1000;
x = 2 * rand(1, N) - 1;
y = 2 * rand(1, N) - 1;

figure;
scatter(x, y, 5, 'filled');
title('1000 random points in $\mathcal{D} = [-1, 1]^2$', ...
      'Interpreter', 'latex');
  
%% Part (b)

N_points = 10 .^ (0:4);
errors = zeros(length(N));

for N = N_points
    x = 2 * rand(1, N) - 1;
    y = 2 * rand(1, N) - 1;
    pi_approx = 4 * sum(sqrt(x.^2 + y.^2) <= 1) / N;
    errors(log10(N) + 1) = abs(pi - pi_approx);
end

figure;
subplot(2, 1, 1);
loglog(N_points, errors);
title('Absolute error in \pi approximation vs. N');
xlabel('N (number of sample points)');
ylabel('Absolute error');

%% Parts (c) and (d)

for N = N_points
    sum_errors = 0;
    
    trials = 100;
    for trial = 1:trials
        x = 2 * rand(1, N) - 1;
        y = 2 * rand(1, N) - 1;
        pi_approx = 4 * sum(sqrt(x.^2 + y.^2) <= 1) / N;
        sum_errors = sum_errors + abs(pi - pi_approx);
    end
    
    errors(log10(N) + 1) = sum_errors / trials;
end

subplot(2, 1, 2);
loglog(N_points, errors);
title('Averaged absolute error (100 trials) in \pi approximation vs. N');
xlabel('N (number of sample points)');
ylabel('Average absolute error');

% Part (d) as an annotation
coeffs = polyfit(log(N_points), log(errors), 1);
annotation('textbox', [0.2, 0.25, 0, 0], 'String', ...
           ['Slope of line = ', num2str(coeffs(1))], 'FitBoxToText', 'on', ...
           'LineStyle', 'none');