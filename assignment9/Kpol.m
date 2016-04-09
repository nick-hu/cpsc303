%{
CPSC 303 Assignment 9 (Capstone)
Pollution Simulation with Convection-Diffusion PDE
Nicholas Hu
%}

function K = Kpol(W, theta, a1, a2, xk)

    persistent D s1 s2 p1x p1y p2x p2y xmin xmax ymin ymax ...
               nx ny nxy dx dy dt tf X Y boundary;

    D = 0.05;

    % Pollution and location parameters

    [s1, s2] = deal(100, 150); % Plume widths
    [p1x, p1y, p2x, p2y] = deal(0.25, 0.25, 0.65, 0.4); % Factory locations

    % Domain

    [xmin, xmax, ymin, ymax] = deal(0, 1, 0, 1);

    % Discretization parameters

    nx = 81;                        % Number of grid points in x-direction
    ny = 81;                        % Number of grid points in y-direction
    nxy = nx * ny;                  % Total number of grid points
    dx = (xmax - xmin) / (nx - 1);  % Grid spacing in x-direction
    dy = (ymax - ymin) / (ny - 1);  % Grid spacing in y-direction
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

    % Backward Euler matrix generation

    B = repelem([dt * (-D/(dx^2) - W*cos(theta)/(2*dx)), ...
                 dt * (-D/(dy^2) - W*sin(theta)/(2*dy)), ...
                 1 + 2*D*dt * (1/(dx^2) + 1/(dy^2)), ...
                 dt * (-D/(dy^2) + W*sin(theta)/(2*dy)), ...
                 dt * (-D/(dx^2) + W*cos(theta)/(2*dx))], nxy, 1);

    A = spdiags(B, [-ny, -1, 0, 1, ny], nxy, nxy);
    A(boundary, :) = 0;
    A(sub2ind(size(A), boundary, boundary)) = 1;
    clear B boundary;

    [L, U, P] = lu(A); % (Faster and more stable for solving Ax = b than LU)
    clear A;

    t = 0:dt:tf;
    kt = zeros(1, length(t)); % Pollution concentrations at kindergarten
    kt(1) = ut(Gk);

    for k = 2:length(t)
        ut = U \ (L \ (P * ut));
        kt(k) = ut(Gk);
    end

    K = trapz(t, kt);
end
