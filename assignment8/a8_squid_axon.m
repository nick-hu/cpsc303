%{
CPSC 303 Assignment 8: Problem 4
The Hodgkin-Huxley Model of Electrical Activity in the Squid Giant Axon
Nicholas Hu
%}

clear variables; clc; format;

diary('a8_squid_axon_output.txt');

%% Part (a)

axon0 = @(t, y) axon(t, y, 0);
axon20 = @(t, y) axon(t, y, 20);
y0 = zeros(4, 1);

[tsol0, Vsol0] = ode45(axon0, [0, 100], y0);
[tsol20, Vsol20] = ode45(axon20, [0, 100], y0);

fprintf('Average time step for Iapp = 0: %g ms\n', ...
        mean(tsol0(2:end) - tsol0(1:end-1)));
fprintf('Average time step for Iapp = 20: %g ms\n', ...
        mean(tsol20(2:end) - tsol20(1:end-1)));

figure;
subplot(2, 1, 1);
plot(tsol0, Vsol0(:, 1));
title('Membrane potential vs. time for $$I_{\mathrm{app}} = 0$$', ...
      'Interpreter', 'latex');
xlabel('Time (ms)');
ylabel('Membrane potential (mV)');

subplot(2, 1, 2);
plot(tsol20, Vsol20(:, 1));
title('Membrane potential vs. time for $$I_{\mathrm{app}} = 20$$', ...
      'Interpreter', 'latex');
xlabel('Time (ms)');
ylabel('Membrane potential (mV)');

%% Part (c)

Iapp = 0:1:20;
npeaks = zeros(1, length(Iapp));

for i = 1:length(Iapp)
    axonI = @(t, y) axon(t, y, Iapp(i));
    [~, Vsol] = ode45(axonI, [0, 1000], y0);
    % Peaks should be at least 60 V (all-or-none law)
    npeaks(i) = length(findpeaks(Vsol(:, 1), 'MinPeakHeight', 60));
end

figure;
plot(Iapp, npeaks, '-o');
title('Neuron firing rate vs. applied current per unit area');
xlabel('$$I_{\mathrm{app}} \, (\mathrm{A / cm^2})$$', ...
       'Interpreter', 'latex');
ylabel('Firing rate (spikes per second)');

diary off;