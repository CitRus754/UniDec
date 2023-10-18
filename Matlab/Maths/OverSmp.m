clear
clc
%
Fs = 10;
f0 = 2;
dt = 1/Fs;
T = 1e4;
N = Fs*T;
t = dt*(0:N-1)';
%
x0 = exp(1i*2*pi*f0*t);

K = 16;
x1 = zeros(K*N,1);
for i = 1:N
    x1(K*(i-1)+1) = x0(i);
    x1(K*(i-1)+2) = x0(i);
end


%%
figure
X_sp    = fftshift(fft(x1));
f = Fs/N*(-K*N/2:K*N/2-1);
plot(f,20*log10(abs(X_sp/(K*N))));
grid on;
xlabel('f');
ylabel('Power, dB');
xlim([-Fs*K/2;Fs*K/2-Fs/N]);
ylim([-90,10]);
title('Input Signal');
