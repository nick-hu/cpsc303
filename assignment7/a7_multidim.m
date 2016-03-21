%{
CPSC 303 Assignment 7: Problem 3
d-dimensional Monte Carlo Integration of the Unnormalized d-dimensional
Isotropic Standard Normal Distribution
Nicholas Hu
%}

clear variables; clc; format;

diary('a7_multidim_output.txt');

%% Part (b)

f = @(x) exp(-1/2 * x.' * x);

N = 1e5;

for d = [1, 2, 3, 10, 50, 100]
    tic; % Part (c) empirical verification of running time growth
    
    N_under = 0; % Count number of sample points which lie under the graph of f   
    for sample = 1:N
        x = rand(d, 1);
        y = rand();
        N_under = N_under + (y <= f(x));
    end
    I_MC = N_under / N;
    I = (erf(1/sqrt(2)) * sqrt(pi/2)) ^ d;
    
    fprintf('Integral estimate (d = %d): %g\n', d, I_MC);
    fprintf('Relative error: %g\n', abs(I - I_MC) / I);
    fprintf('Running time: %g s\n\n', toc);
end

diary off;