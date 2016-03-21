%{
CPSC 303 Assignment 7: Problem 5
Rejection and Importance Sampling of an Unnormalized Probability Density
Function
Nicholas Hu
%}

clear variables; clc; format;

diary('a7_sampling_output.txt');

%% Part (b)

N = 1e5;
M = 1000;

means = zeros(1, M);
vars = zeros(1, M);
num_samples = zeros(1, M);

for trial = 1:M
    samples = sample_reject(N);
    means(trial) = mean(samples);
    vars(trial) = var(samples);
    num_samples(trial) = length(samples);
end

true_mean = 0;
true_var = 0.337989;

fprintf('Rejection sampling:\n\nEstimated mean of p(x): %g\n', mean(means));
fprintf('RMS error in mean estimate: %g\n\n', ...
        sqrt(sum((means - true_mean).^2) / M));
fprintf('Estimated variance of p(x): %g\n', mean(vars));
fprintf('RMS error in variance estimate: %g\n\n', ...
        sqrt(sum((vars - true_var).^2) / M));

%% Part (c)
    
fprintf('Average number of samples generated: %g\n\n\n', mean(num_samples));

%% Part (d)

p = @(x) exp(-x.^4);
q = @(x) 1.5 * exp(-x.^2);
x = linspace(-10, 10, 1000);

plot(x, p(x), x, q(x), '-.');
legend({'$$p(x) = \exp(-x^4)$$', '$$q(x) = 1.5 \exp(-x^2)$$'}, ...
       'Interpreter', 'latex');
   
%% Part (f)

for trial = 1:M
    samples = sample_import(N);
    means(trial) = mean(samples);
    vars(trial) = var(samples);
end

fprintf('Importance sampling:\n\nEstimated mean of p(x): %g\n', mean(means));
fprintf('RMS error in mean estimate: %g\n\n', ...
        sqrt(sum((means - true_mean).^2) / M));
fprintf('Estimated variance of p(x): %g\n', mean(vars));
fprintf('RMS error in variance estimate: %g\n\n', ...
        sqrt(sum((vars - true_var).^2) / M));
    
diary off;