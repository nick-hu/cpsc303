%{
CPSC 303 Assignment 4
Helper function: Computation of DFT coefficients
Nicholas Hu
%}

function [a, b] = dftcoefs(y)
    l = length(y) / 2;
    x = linspace(0, (2*l - 1)*pi / l, 2*l);
    
    a = zeros(1, l+1);
    b = zeros(1, l+1);

    for k = 0:l
        a(k+1) = sum(y .* cos(k*x)) / l;
        b(k+1) = sum(y .* sin(k*x)) / l;
    end
end