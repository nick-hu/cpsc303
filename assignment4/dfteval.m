%{
CPSC 303 Assignment 4
Helper function: Evaluation of trigonometric polynomial using DFT
coefficients
Nicholas Hu
%}

function p = dfteval(mesh, a, b)
    l = length(a) - 1;
    p = (a(1) + a(end) * cos(l*mesh)) / 2;

    for k = 1:l-1
        p = p + (a(k+1) * cos(k*mesh) + b(k+1) * sin(k*mesh));
    end
end