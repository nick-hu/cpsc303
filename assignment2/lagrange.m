%{
CPSC 303 Assignment 2
Parts (f) and (g)
Nicholas Hu
%}

function y_test = lagrange(x, y, x_test)
    % Compute barycentric weights
    [A, B] = meshgrid(x);
    w = 1 ./ prod(A - B + eye(length(x)));
    wy = w .* y;
    
    % Evaluation
    num = sum(bsxfun(@rdivide, wy.', bsxfun(@minus, x_test, x.')));
    denom = sum(bsxfun(@rdivide, w.', bsxfun(@minus, x_test, x.')));
    y_test = num ./ denom;
    
    % Handle case where evaluation point is an abscissa
    y_test(isnan(y_test)) = 1;
    [in_x, index_x] = ismember(x_test, x);
    index_x(~index_x) = 1; % Temporary value so that index 0 is not used
    y_test = y_test .* (y(index_x) .* in_x + ~in_x);
end