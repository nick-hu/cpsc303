%{
CPSC 303 Assignment 2
Part (c)
Nicholas Hu
%}

function y_test = monomial(x, y, x_test)
    n = length(x);

    A = zeros(n);
    for col = 1:n
        A(:, col) = x.' .^ (col-1);
    end
    
    c = A \ y.';
    
    % Horner's rule evaluation
    y_test = zeros(1, length(x_test));
    for j = n:-1:1
        y_test = y_test .* x_test + c(j);
    end
end