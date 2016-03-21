%{
CPSC 303 Assignment 7: Problem 5
Part (a): Rejection sampler
Nicholas Hu
%}

function samples = sample_reject(N)
    % Apply Monte Carlo integration on [-xmax, xmax] x [0, 1], where 
    % xmax = 10
    
    xmax = 10;
    
    p = @(x) exp(-x.^4);
    x = 2 * xmax * rand(1, N) - xmax;
    y = rand(1, N);
    
    samples = x .* (y <= p(x));
    samples = samples(samples ~= 0);
end