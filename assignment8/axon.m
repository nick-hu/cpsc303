%{
CPSC 303 Assignment 8: Problem 4
The Hodgkin-Huxley Model of Electrical Activity in the Squid Giant Axon
Nicholas Hu
%}

function dy = axon(~, y, Iapp)
    % Constants
    
    persistent Cm gNa gK gL VNa VK VL;

    Cm = 1;     % Membrane capacitance per unit area (uF/cm^2)
    gNa = 120;  % Sodium conductance (mS/cm^2)
    gK = 36;    % Potassium conductance (mS/cm^2)
    gL = 0.3;   % Leakage conductance (mS/cm^2)
    VNa = 115;  % Sodium reversal potential (mV)
    VK = -12;   % Potassium reversal potential (mV)
    VL = 10.6;  % Leakage reversal potential (mV)

    % Voltage-dependent rate constants for ion channels
    
    persistent am bm ah bh an bn;
    
    am = @(V) 0.1 * (25 - V) / (exp((25 - V) / 10) - 1);
    bm = @(V) 4 * exp(-V / 18);
    ah = @(V) 0.07 * exp(-V / 20);
    bh = @(V) 1 / (exp((30 - V) / 10) + 1);
    an = @(V) 0.01 * (10 - V) / (exp((10 - V) / 10) - 1);
    bn = @(V) 0.125 * exp(-V / 80);
    
    % Four coupled nonlinear ODEs
    
    V = y(1);   % Membrane potential (V)
    m = y(2);   % Sodium channel activation (dimensionless)
    n = y(3);   % Potassium channel activation (dimensionless)
    h = y(4);   % Sodium channel inactivation (dimensionless)
    
    dy = zeros(4, 1);
    dy(1) = (-gK * n^4 * (V - VK) - gNa * m^3 * h * (V - VNa) ...
             -gL * (V - VL) + Iapp) / Cm;
    dy(2) = (1 - m) * am(V) - m * bm(V);
    dy(3) = (1 - n) * an(V) - n * bn(V);
    dy(4) = (1 - h) * ah(V) - h * bh(V);
end