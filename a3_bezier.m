%{
CPSC 303 Assignment 3: Problem 4
Bézier Curves
Nicholas Hu, with credit to Wilson Hsu for his artistic guidance :)
%}

clear variables; clc; format;

diary('a3_bezier_output.txt');

NUM_CURVES = 8;

figure;
axis([0, 1, 0, 1]);
grid on;
hold on;

figure;
axis([0, 1, 0, 1]);
hold on;

for curve = 1:NUM_CURVES
    fprintf('Curve %d\n', curve);
    
    figure(1);
    
    [x0, y0] = ginput(1);
    plot(x0, y0, 'k.');
    [X0, Y0] = ginput(1);
    plot([x0, X0], [y0, Y0], 'k.:');
    [x1, y1] = ginput(1);
    plot(x1, y1, 'k.');
    [X1, Y1] = ginput(1);
    plot([x1, X1], [y1, Y1], 'k.:');

    fprintf('Interpolation points: (%g, %g), (%g, %g)\n', x0, y0, x1, y1);
    fprintf('Guidepoints: (%g, %g), (%g, %g)\n', X0, Y0, X1, Y1);

    a0 = X0 - x0;
    b0 = Y0 - y0;
    a1 = x1 - X1;
    b1 = y1 - Y1;

    t = linspace(0, 1, 100);
    
    x_coeffs = [2*(x0-x1) + 3*(a0+a1), 3*(x1-x0) - 3*(a1+2*a0), 3*a0, x0];
    y_coeffs = [2*(y0-y1) + 3*(b0+b1), 3*(y1-y0) - 3*(b1+2*b0), 3*b0, y0];
    
    plot(polyval(x_coeffs, t), polyval(y_coeffs, t), 'r');
    figure(2);
    plot(polyval(x_coeffs, t), polyval(y_coeffs, t), 'r');
    
    fprintf('\n');
end

diary off;