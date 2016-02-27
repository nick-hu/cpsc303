%{
CPSC 303 Assignment 4: Problem 3
Interpolation of Logarithmic Function with Trigonometric Polynomials
Nicholas Hu
%}

clear variables; clc; format;

diary('a4_dftlog_output.txt');

for l = 2.^[4:5]
    % Interpolate log(x + 1)
    
    x = linspace(0, (2*l - 1)*pi / l, 2*l);
    y = log(x + 1);

    [a, b] = dftcoefs(y);
    
    mesh = 0:pi/500:2*pi;
    p = dfteval(mesh, a, b);
    
    f = log(mesh + 1);
    
    fprintf('Max. abs. error for l = %d (without extension): %f\n', ...
            l, max(abs(f - p)));
    
    subplot(2, 2, log2(l) - 3);
    plot(mesh, p);
    axis([0, 2*pi, -inf, inf]);
    hold on;
    plot(mesh, f, '--');
    title(['l = ', num2str(l), ' (without even extension)'], ...
           'Interpreter', 'latex');
    
    % Interpolate even extension of log(x + 1) using scaling t = 2x
    
    t = 2 * x;
    gtpi = bsxfun(@and, (2*pi <= t), (t < 4*pi));
    y = log(((-2*gtpi+1) .* t + 4*pi*gtpi) + 1);
    
    [a, b] = dftcoefs(y);
    
    tmesh = mesh ./ 2; % The mesh becomes twice as fine
    p = dfteval(tmesh, a, b);
    
    fprintf('Max. abs. error for l = %d (with extension): %f\n', ...
            l, max(abs(f - p)));
    
    subplot(2, 2, log2(l) - 1);
    plot(mesh, p);
    axis([0, 2*pi, -inf, inf]);
    hold on;
    plot(mesh, f, '--');
    title(['l = ', num2str(l), ' (with even extension)'], ...
           'Interpreter', 'latex');
end

diary off;