clear
close all
clc
%
Fs = 1e3;
dt = 1/Fs;
T = 10;
N = T*Fs;
t = dt*(0:N-1)';
%%
w0 = 2*pi*25;
% information
inf_seq = repmat([1+1i;-1+1i;1-1i;1+1i;1+1i;-1-1i;1-1i;-1+1i;1+1i;-1-1i],1000,1);
% inf_a = hilbert(inf_seq);
%
figure
plot3(t,real(inf_seq),imag(inf_seq));
grid on
xlabel('t');
ylabel('real(i)');
zlabel('imag(i)');
%%
% Omg = 2*pi*10;
x = inf_seq.*cos(w0*t);
% x = cos((w0+0.2*cos(Omg*t)*100).*t);
xa = hilbert(x);
%
figure
plot3(t,real(xa),imag(xa));
grid on
xlabel('t');
ylabel('real(x)');
zlabel('imag(x)');

%%
mix = xa.*exp(-1i*(4*w0/4)*t);
%
figure
plot3(t,real(mix),imag(mix));
grid on
xlabel('t');
ylabel('real(mix)');
zlabel('imag(mix)');

%%
df = Fs/N;
f = -Fs/2:df:Fs/2-df;
X = fftshift(fft(xa));
%
figure
plot3(f,real(X),imag(X));
grid on;
xlabel('f');
ylabel('real(X)');
zlabel('imag(X)');

%%
Xm = fftshift(fft(mix));
%
figure
plot3(f,real(Xm),imag(Xm));
grid on;
xlabel('f');
ylabel('real(Xm)');
zlabel('imag(Xm)');

