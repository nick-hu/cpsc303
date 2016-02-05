%{
CPSC 303 Assignment 3: Problem 2
Piecewise Polynomial Interpolation
Nicholas Hu
%}

clear variables; clc; format;

diary('a3_piecewise_output.txt');

x = linspace(0, pi, 11);
a = [0.1, 1, 12];

x_test = linspace(0, pi, 200);

figure;

for i = 1:length(a)
    y = sin(a(i) * x);
    y_true = sin(a(i) * x_test);
    
    subplot(2, 3, i);

    % Actual function and abscissae
    plot(x_test, y_true, 'k--');
    hold on;
    plot(x, y, 'ko');
    
    vals = [polyval(polyfit(x, y, 10), x_test); % Global 10th degree polynomial
            interp1(x, y, x_test, 'spline'); % Cubic spline (not-a-knot)
            interp1(x, y, x_test, 'linear'); % Piecewise linear
            interp1(x, y, x_test, 'nearest')]; % Piecewise constant
    
    for j = 1:size(vals, 1)
        plot(x_test, vals(j, :));
    end
    
    title(['Polynomial approximations to $\sin(', num2str(a(i)), 'x)$'], 'Interpreter', 'latex');
    
    subplot(2, 3, 3 + i);
    
    errors = abs(bsxfun(@minus, y_true, vals));
    
    for j = 1:size(errors, 1)
        semilogy(x_test, errors(j, :));
        if j == 1
            hold on; % Hold must occur after first plot is drawn
        end
    end
    
    % Part (b) error analysis
    
    title(['Error in approximations to $\sin(', num2str(a(i)), 'x)$'], 'Interpreter', 'latex');
    
    names = {'10th degree polynomial'; 'Cubic spline'; 'Piecewise linear'; 'Piecewise constant'};
    fprintf('MAXIMUM ERRORS IN APPROXIMATIONS OF sin(%gx)\n', a(i));
    for j = 1:length(names)
        fprintf('%s: %g\n', names{j}, max(errors(j, :)));
    end
    fprintf('\n');
    
    fprintf('THEORETICAL ERROR BOUNDS IN APPROXIMATIONS OF sin(%gx)\n', a(i));
    fprintf('%s: %g\n', names{1}, 1/gamma(12) * abs(a(i)^11) * 1.2257);
    fprintf('%s: %g\n', names{2}, a(i)^4 * (pi/10)^4);
    fprintf('%s: %g\n', names{3}, (a(i)^2 / 8) * (pi/10)^2);
    fprintf('%s: %g\n', names{4}, (a(i) / 2) * (pi/10));
    fprintf('\n\n');
end

diary off;