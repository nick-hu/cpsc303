%{
CPSC 303 Assignment 7: Problem 4
Comparison of Monte-Carlo and Quasi-Monte Carlo Integration
Nicholas Hu
%}

clear variables; clc; format;

diary('a7_quasimc_output.txt');

%% Part (a)

N = 1000;
points = 2 * net(haltonset(2), N) - 1;

figure;
scatter(points(:, 1), points(:, 2), 5, 'filled');
title('1000 quasi-random points in $\mathcal{D} = [-1, 1]^2$', ...
      'Interpreter', 'latex');
  
%% Part (b)

% Names with U pertain to uniformly random Monte Carlo
% Names with Q pertain to quasirandom Monte Carlo (i.e., Quasi-Monte Carlo)

N_points = 10 .^ (0:4);
errorsU = zeros(length(N));
errorsQ = zeros(length(N));

for N = N_points
    sum_errorsU = 0;
    sum_errorsQ = 0;
    trials = 100;
    
    for trial = 1:trials
        points = 2 * rand(N, 2) - 1;
        pi_U = 4 * sum(sqrt(points(:, 1).^2 + points(:, 2).^2) <= 1) / N;
        sum_errorsU = sum_errorsU + abs(pi - pi_U);
        
        points = 2 * net(haltonset(2), N) - 1;
        pi_Q = 4 * sum(sqrt(points(:, 1).^2 + points(:, 2).^2) <= 1) / N;
        sum_errorsQ = sum_errorsQ + abs(pi - pi_Q);
    end
    
    errorsU(log10(N) + 1) = sum_errorsU / trials;
    errorsQ(log10(N) + 1) = sum_errorsQ / trials;
end

figure;
loglog(N_points, errorsU, N_points, errorsQ, '-.');
title('Averaged absolute error (100 trials) in \pi approximation vs. N');
xlabel('N (number of sample points)');
ylabel('Average absolute error');
legend('Monte Carlo (uniformly random numbers)', ...
       'Quasi-Monte Carlo (quasirandom numbers)');
   
%% Part (c)

N = 1e6;

points = 2 * rand(N, 2) - 1;
pi_U = 4 * sum(sqrt(points(:, 1).^2 + points(:, 2).^2) <= 1) / N;

points = 2 * net(haltonset(2), N) - 1;
pi_Q = 4 * sum(sqrt(points(:, 1).^2 + points(:, 2).^2) <= 1) / N;

fprintf('True value:\t\t\tpi = %.15f\n', pi);
fprintf('Monte Carlo:\t\tpi = %.15f\n', pi_U);
fprintf('Quasi-Monte Carlo:\tpi = %.15f\n', pi_Q);

diary off;
