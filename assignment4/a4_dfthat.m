%{
CPSC 303 Assignment 4: Problem 2
Interpolation of Hat Function with Trigonometric Polynomials
Nicholas Hu
%}

clear variables; clc; format;

diary('a4_dfthat_output.txt');

for l = 2.^[1:5]
    % Generate ordinates
    
    x = linspace(0, (2*l - 1)*pi / l, 2*l);
    gtpi = bsxfun(@and, (pi < x), (x <= 2*pi));
    y = (-2*gtpi+1) .* x + 2*pi*gtpi;
    
    % Compute DFT coefficients
    
    [a, b] = dftcoefs(y); 
    
    % Evaluate trigonometric polynomial on mesh
    
    mesh = 0:pi/100:2*pi;
    p = dfteval(mesh, a, b);
    
    % Evaluate on hat function on mesh
 
    gtpi = bsxfun(@and, (pi < mesh), (mesh <= 2*pi));
    hat = (-2*gtpi+1) .* mesh + 2*pi*gtpi;

    fprintf('Max. abs. error for l = %d: %f\n', l, max(abs(hat - p)));

    % Plots for fun :)
    
    subplot(3, 2, log2(l));
    plot(mesh, p);
    axis([0, 2*pi, 0, pi]);
    hold on;
    plot(mesh, hat, '--');
    title(['l = ', num2str(l)], 'Interpreter', 'latex');
end

diary off;