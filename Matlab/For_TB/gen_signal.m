clear
close all
clc
%
Fs = 44e6;
dt = 1/Fs;
T = 0.01;
N = T*Fs;
t = dt*(0:N-1);
% am-signal
m   = 0.8;          % modulation index
Omg = 2*pi*5e5;    % information frequency
w0  = 2*pi*5e6;     % carrier
DataIn = (1 + m*cos(Omg*t)).*exp(1i*w0*t);

%% spectrum
dF = Fs/N;
f = dF*(-N/2:N/2-1);
SpectrumIn = fftshift(fft(DataIn));
%
figure
plot(f,20*log10(abs(SpectrumIn/N)));
grid on;
xlabel('f');
ylabel('Power, dB');
xlim([-Fs/2;Fs/2-dF]);
ylim([-90,10]);



