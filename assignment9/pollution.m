%{
CPSC 303 Assignment 9 (Capstone): Parts (e) to (i)
Pollution Simulation with Convection-Diffusion PDE
Nicholas Hu
%}

clear variables; clc; format;

diary('a9_pollution_output.txt');
fprintf('====================\n');
tic;

D = 0.05;       % Diffusion coefficient

% Wind parameters

W = 1;          % Wind strength
theta = pi/2;   % Wind direction

% Pollution and location parameters

[a1, a2, s1, s2] = deal(2, 1, 100, 150); % Plume intensities and widths
[p1x, p1y, p2x, p2y] = deal(0.25, 0.25, 0.65, 0.4); % Factory locations
xk = [0.5, 0.5]; % Kindergarten location

% Domain

[xmin, xmax, ymin, ymax] = deal(0, 1, 0, 1);

% Discretization parameters

nx = 81;                        % Number of grid points in x-direction
ny = 81;                        % Number of grid points in y-direction
nxy = nx * ny;                  % Total number of grid points
dx = (xmax - xmin) / (nx - 1);  % Grid spacing in x-direction
dy = (ymax - ymin) / (ny - 1);  % Grid spacing in y-direction
% dt = 0.025;                     % Timestep (part (e) only)
dt = 0.005;                     % Timestep
tf = 0.25;                      % Final time

% Initial conditions

icond = @(X, Y) a1 * exp(-s1 * ((X - p1x).^2 + (Y - p1y).^2)) + ...
                a2 * exp(-s2 * ((X - p2x).^2 + (Y - p2y).^2));

[X, Y] = meshgrid(xmin:dx:xmax, ymin:dy:ymax);
ut = reshape(icond(X, Y), [], 1);
clear X Y a1 a2 s1 s2 p1x p1y p2x p2y;

% Boundary conditions

boundary = [1:ny, (nxy-ny+1):nxy, (ny+1):ny:(nxy-ny), (2*ny):ny:(nxy-ny)];
ut(boundary) = 0;

% Grid index to linear index function
G = @(i, j) ny * (j - 1) + i;
% Linear index of kindergarten location
Gk = G(round((xk(2) - ymin) / dy) + 1, round((xk(1) - xmin) / dx) + 1);

%% Backward Euler matrix generation

%{
%% Part (e)

A = eye(nxy);

for i = 2:ny-1
    for j = 2:nx-1
        A(G(i, j), G(i, j)) = 1 + 2*D*dt * (1/(dx^2) + 1/(dy^2));
        A(G(i, j), G(i, j+1)) = dt * (-D/(dx^2) + W*cos(theta)/(2*dx));
        A(G(i, j), G(i, j-1)) = dt * (-D/(dx^2) - W*cos(theta)/(2*dx));
        A(G(i, j), G(i+1, j)) = dt * (-D/(dy^2) + W*sin(theta)/(2*dy));
        A(G(i, j), G(i-1, j)) = dt * (-D/(dy^2) - W*sin(theta)/(2*dy));
    end
end

fprintf('Number of nonzero elements in A: %g\n\n', nnz(A));

%% Part (f)

fprintf('Fraction of nonzero elements in A: %g\n\n', nnz(A) / numel(A));
A = sparse(A);
%}

%% Part (g)

B = repelem([dt * (-D/(dx^2) - W*cos(theta)/(2*dx)), ...
             dt * (-D/(dy^2) - W*sin(theta)/(2*dy)), ...
             1 + 2*D*dt * (1/(dx^2) + 1/(dy^2)), ...
             dt * (-D/(dy^2) + W*sin(theta)/(2*dy)), ...
             dt * (-D/(dx^2) + W*cos(theta)/(2*dx))], nxy, 1);

A = spdiags(B, [-ny, -1, 0, 1, ny], nxy, nxy);
A(boundary, :) = 0;
A(sub2ind(size(A), boundary, boundary)) = 1;
clear B boundary;

%% Part (h)

[L, U, P] = lu(A); % (Faster and more stable for solving Ax = b than LU)
clear A;

%% Simulation

figure;
contour(xmin:dx:xmax, ymin:dy:ymax, reshape(ut, ny, nx), 50);
colorbar;
title('Pollution concentrations at time t = 0');
axis equal;

t = 0:dt:tf;
kt = zeros(1, length(t)); % Pollution concentrations at kindergarten
kt(1) = ut(Gk);

for k = 2:length(t)
    % ut = A \ ut; % Parts (e) to (g) only
    ut = U \ (L \ (P * ut));
    
    if t(k) == 0.125 || t(k) == tf
        figure;
        contour(xmin:dx:xmax, ymin:dy:ymax, reshape(ut, ny, nx), 50);
        colorbar;
        title(['Pollution concentrations at time t = ', num2str(t(k))]);
        axis equal;
    end
    
    kt(k) = ut(Gk);
end

fprintf('Time elapsed: %g s\n', toc);

%% Part (i)

figure;
plot(t, kt);
title(['Concentration of pollution at kindergarten location ', ...
       '$$\mathbf{x}_\mathrm{K} = [', num2str(xk(1)), ', ' num2str(xk(2)), ...
       ']$$ vs. time'], 'Interpreter', 'latex');
xlabel('Time ($$t$$)', 'Interpreter', 'latex');
ylabel('Concentration of pollution ($$k$$)', 'Interpreter', 'latex');

K = trapz(t, kt);
fprintf('(Total) daily pollution experienced at kindergarten: %g\n', K);

diary off;
