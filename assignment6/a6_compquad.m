%{
CPSC 303 Assignment 6: Problem 1
Comparison of Composite Quadrature Methods
Nicholas Hu
%}

clear variables; clc; format;

%% Part (a)

f = @(x) 5 ./ (1 + 25*x.^2);
I2 = atan(5);
a = 0;
b = 1;

errors = zeros(4, 6);

for r = 2.^(1:6)
    h = (b - a) / r;
    col = log2(r);
    
    % (i) Composite trapezoidal
    I_trap = (h/2) * (f(a) + 2 * sum(f(a+h : h : b-h)) + f(b));
    errors(1, col) = abs(I2 - I_trap);
    
    % (ii) Composite midpoint
    I_mid = h * sum(f(a + h/2 : h : b - h/2));
    errors(2, col) = abs(I2 - I_mid);
    
    % (iii) Composite Simpson
    I_Simp = (h/3) * (f(a) + 2 * sum(f(a + 2*h : 2*h : b - 2*h)) + ...
                      4 * sum(f(a+h : 2*h : b-h)) + f(b));
    errors(3, col) = abs(I2 - I_Simp);
    
    % (iv) Composite Gaussian (n = 1, two samples)
    I_Gauss = 0;
    for i = 1:r
        p = a + (i-1)*h;
        q = a + i*h;
        I_Gauss = I_Gauss + f((p+q)/2 - (q-p)/(2*sqrt(3))) + ...
                            f((p+q)/2 + (q-p)/(2*sqrt(3)));
    end
    I_Gauss = (h/2) * I_Gauss;
    errors(4, col) = abs(I2 - I_Gauss);
end

figure;
h = (b - a) ./ (2.^(1:6));
linespec = {'r-', 'b-.', 'k--', 'm:'};

for method = 1:4
    loglog(h, errors(method, :), [linespec{method}, 'o'], ...
           'MarkerFaceColor', linespec{method}(1));
    hold on;
end

legend('Trapezoidal', 'Midpoint', 'Simpson', 'Gaussian (n=1)', ...
       'Location', 'best')
   
% Reference lines
for slope = 2:2:6
    loglog(h, 2^(slope-4) * h.^slope, 'Color', [0.5, 0.5, 0.5]);
    hold on;
end

title(['Convergence of various composite quadrature rules for ', ...
       '$\int_0^1 \frac{5}{1 + 25x^2} \, dx$'], 'Interpreter', 'latex');
xlabel('$h$ (panel size)', 'Interpreter', 'latex');
ylabel('Absolute error', 'Interpreter', 'latex')

%% Part (b)

errors(:, 7:12) = zeros(size(errors, 1), 6);

for r = 2.^(7:12)
    h = (b - a) / r;
    col = log2(r);

    I_trap = (h/2) * (f(a) + 2 * sum(f(a+h : h : b-h)) + f(b));
    errors(1, col) = abs(I2 - I_trap);

    I_mid = h * sum(f(a + h/2 : h : b - h/2));
    errors(2, col) = abs(I2 - I_mid);

    I_Simp = (h/3) * (f(a) + 2 * sum(f(a + 2*h : 2*h : b - 2*h)) + ...
                      4 * sum(f(a+h : 2*h : b-h)) + f(b));
    errors(3, col) = abs(I2 - I_Simp);

    I_Gauss = 0;
    for i = 1:r
        p = a + (i-1)*h;
        q = a + i*h;
        I_Gauss = I_Gauss + f((p+q)/2 - (q-p)/(2*sqrt(3))) + ...
                            f((p+q)/2 + (q-p)/(2*sqrt(3)));
    end
    I_Gauss = (h/2) * I_Gauss;
    errors(4, col) = abs(I2 - I_Gauss);
end

figure;
h = (b - a) ./ (2.^(1:12));
linespec = {'r-', 'b-.', 'k--', 'm:'};

for method = 1:4
    loglog(h, errors(method, :), [linespec{method}, 'o'], ...
           'MarkerFaceColor', linespec{method}(1));
    hold on;
end

legend('Trapezoidal', 'Midpoint', 'Simpson', 'Gaussian (n=1)', ...
       'Location', 'best')

for slope = 2:2:6
    loglog(h, 2^(slope-4) * h.^slope, 'Color', [0.5, 0.5, 0.5]);
    hold on;
end

title(['Convergence of various composite quadrature rules for ', ...
       '$\int_0^1 \frac{5}{1 + 25x^2} \, dx$'], 'Interpreter', 'latex');
xlabel('$h$ (panel size)', 'Interpreter', 'latex');
ylabel('Absolute error', 'Interpreter', 'latex')