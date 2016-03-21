%{
CPSC 303 Assignment 0: Problem 4
Speed of Matrix Multiplication
Nicholas Hu
%}

clear variables; clc;

%% Part (a)

A = randi(100, 100);
B = randi(100, 100);

tic;
A * B;
fprintf('Two 100x100 matrices multiplied together in %f seconds.\n', toc);

%% Part (b)

N = 10:10:1000;
time = zeros(size(N));

for trial = 1:length(N)
    A = randi(100, N(trial));
    B = randi(100, N(trial));
    
    tic;
    AB = A * B;
    time(trial) = toc;
end

figure;
plot(N, time, '*');

title('Multiplication time of two N by N matrices vs. N');
xlabel('N');
ylabel('Time (seconds)');

%% Parts (c) and (d)

N_loops = 10:10:300;
time_loops = zeros(size(N_loops));

for trial = 1:length(N_loops)
    A = randi(100, N_loops(trial));
    B = randi(100, N_loops(trial));
    
    tic;

    AB = zeros(size(A, 1), size(B, 2));

    % Loop multiplication
    for row = 1:size(AB, 1)
        for col = 1:size(AB, 2)
            for i = 1:size(A, 2)
                AB(row, col) = AB(row, col) + A(row, i) * B(i, col);
            end
        end
    end
    
    time_loops(trial) = toc;
end

figure;
semilogy(N, time, '*');
hold on;
semilogy(N_loops, time_loops, 'rx');

title('Multiplication time of two N by N matrices vs. N');
xlabel('N');
ylabel('Time (seconds)');
legend('MATLAB matrix multiplication', 'Iterative matrix multiplication');
