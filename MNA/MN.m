clear;
close all;

%%% Set Values %%%
R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
R0 = 1000;

C1 = 0.25;
L1 = 0.2;

alpha = 100;

omega=3*pi; 

%%% Set Up Matrices %%%

G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G0 = 1/R0;

G = zeros(8);   % G Matrix
Cm = zeros(8);  % C Matrix

G(1,:) = [1 G1 -G1 0 0 0 0 0];
G(2,:) = [0 -G1 G1+G2 1 0 0 0 0];
G(3,:) = [0 0 0 -1 1 0 0 0];
G(4,:) = [0 0 0 0 0 -1 G4 -G4];
G(5,:) = [0 0 0 0 0 0 -G4 G4+G0];
G(6,:) = [0 1 0 0 0 0 0 0];
G(7,:) = [0 0 0 0 -alpha 0 1 0];
G(8,:) = [0 0 1 0 -G3 0 0 0];

Cm(1,:) = [0 C1 -C1 0 0 0 0 0];
Cm(2,:) = [0 -C1 C1 0 0 0 0 0];
% Cm(3,:) = [0 0 0 0 0 0 0 0];
% Cm(4,:) = [0 0 0 0 0 0 0 0];
% Cm(5,:) = [0 0 0 0 0 0 0 0];
% Cm(6,:) = [0 0 0 0 0 0 0 0];
% Cm(7,:) = [0 0 0 0 0 0 0 0];
Cm(8,:) = [0 0 0 -L1 0 0 0 0];

count = 1;  % Indexing counter

for Vin = -10:10
    
    F = [0 0 0 0 0 Vin 0 0];
    X = G\F';
    
    Vout(count) = X(8);
    V3(count) = X(5)*R3; % X(5) has I3
    
    count = count + 1;  % Increment counter
    
end

Vin = linspace(-10,10,21);  % Generate array for Vin


%%% Plot Transient %%%
figure(1)
plot(Vin,Vout)
hold on
plot(Vin,V3)
xlabel('Vin (V)')
ylabel('Voltage at Node (V)')
legend('Vout','V3')
hold off


%%% Plot Over Frequency %%% 
Vin = 1;

Vout = [];
V3 = [];

count = 1;  % Reset count

for freq = 0:100
    
    w = 2*pi*freq;  % Convert to angular frequency
    X = (G + 1i*w*Cm)\F';
    
    Vout(count) = real(X(8));
    V3(count) = real(X(5))*R3; % X(5) has I3
    
    count = count + 1;  % Increment counter
    
end

freq = linspace(0,100,101);

figure(2)
plot(freq,Vout)
hold on
plot(freq,V3)
xlabel('Frequency (Hz)')
ylabel('Voltage at Node (V)')
legend('Vout','V3')
hold off

%%% Plot Gain %%% 
figure(3)
plot(freq,20*log10(Vout/Vin))
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')

%%% Plot Varying C1 %%%
for count = 1:100

    C1 = 0.05*randn + 0.25; % Multiply C1 by rand, increment by .25
    
    C_Varied(count) = C1;
    
    C(1,:) = [0 C1 -C1 0 0 0 0 0];
    C(2,:) = [0 -C1 C1 0 0 0 0 0];
%     C(3,:) = [0 0 0 0 0 0 0 0];
%     C(4,:) = [0 0 0 0 0 0 0 0];
%     C(5,:) = [0 0 0 0 0 0 0 0];
%     C(6,:) = [0 0 0 0 0 0 0 0];
%     C(7,:) = [0 0 0 0 0 0 0 0];
    C(8,:) = [0 0 0 -L1 0 0 0 0];
    
    X = (G + 1i*omega*C)\F';
    
    gain(count) = 20*log10(abs(X(8))/Vin);  % Calc gain
    
    count = count + 1;  % Increment counter

end


%%% Plot C1 Distribution %%%
figure(4)
hist(C_Varied)
title('Capacitance Distribution')
xlabel('Capacitance (F)')

%%% Plot Gain Spread %%%
figure(5)
hist(gain)
title('Gain Spread')
xlabel('Gain (dB)')