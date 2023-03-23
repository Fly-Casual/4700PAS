close all;
clear;

I_s = 0.01e-12; %Forward Bias Saturation Current
I_b = 0.1e-12; %Breakdown Saturation Current
V_b = 1.3; %Breakdown Voltage
G_p = 0.1; %Parasitic Parallel Conductance

V = linspace(-1.95, 0.7, 200);

I = I_s*(exp((1.2/0.025)*V) - 1) + G_p*V - I_b*(exp(-(1.2/0.025)*(V + V_b)) - 1);

var = 0.4*(rand(1,200)); %Random number from 0 to 0.4

I_n = I.*(0.2*var + 0.8); %Generate Noise (20%)

%%%%% Create Polynomials %%%%%

p4 = polyfit(V,I,4);
p8 = polyfit(V,I,8);

I_P4 = p4(1).*V.^4 + p4(2).*V.^3 + p4(3).*V.^2 + p4(4).*V.^1 + p4(5);
I_P4_n = I_P4.*(0.2*var + 0.8);
I_P8 = p8(1).*V.^8 + p8(2).*V.^7 + p8(3).*V.^6 + p8(4).*V.^5 + p8(5).*V.^4 + p8(6).*V.^3 + p8(7).*V.^2 + p8(8).*V + p8(9);
I_P8_n = I_P8.*(0.2*var + 0.8);


%%%%% Non linear curve fitting %%%%%

fo = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff = fit(V',I',fo);
If = ff(V);

%%%%% 

%%%%% Output Plots %%%%%

subplot(2,2,1)  % No noise
plot(V,I)
xlabel('Voltage (V)')
ylabel('Current (A)')

hold on

plot(V,I_P4)
plot(V,I_P8)
plot(V,If,'ro')
hold off


subplot(2,2,2)  % Semilog no noise
semilogy(V,abs(I))

hold on
semilogy(V,abs(I_P4))
semilogy(V,abs(I_P8))
semilogy(V,abs(If),'ro')
xlabel('Voltage (V)')
ylabel('|Current| (A)')
hold off

subplot(2,2,3)  % No noise
plot(V,I)
xlabel('Voltage (V)')
ylabel('Current With Noise (A)')
hold on
plot(V,I_P4)
plot(V,I_P8)
plot(V,If,'ro')
hold off

subplot(2,2,4)  % Semilog noise
semilogy(V,abs(I_n))
hold on
semilogy(V,abs(I_P4))
semilogy(V,abs(I_P8))
semilogy(V,abs(If),'ro')
hold off
xlabel('Voltage (V)')
ylabel('|Current With Noise| (A)')