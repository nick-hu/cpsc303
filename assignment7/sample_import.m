%{
CPSC 303 Assignment 7: Problem 5
Parts (e) and (f): Importance sampler
Nicholas Hu
%}

function samples = sample_import(N)
    % Part (e)
    
    q = @(x) 1.5 * exp(-x.^2);

    x = sqrt(0.5) .* randn(1, N); % Variance of normalized q is 0.5
    y = q(x) .* rand(1, N);
    
    % Part (f)
    
    p = @(x) exp(-x.^4);
    
    samples = x .* (y <= p(x));
    samples = samples(samples ~= 0);
end