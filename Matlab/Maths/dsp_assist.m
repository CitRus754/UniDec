clear
close all
clc
%
Fs = 1000;
T = 1/Fs;
dt  = 1e-6;
t   = -10*T:dt:10*T-dt;
% s   = sin(pi*(t-2*T)/T)./(pi*(t-2*T)/T);
s   = sin(1./(pi*t/T));
% sd  = (t.*cos(t) - sin(t))./t.^2;
%
figure
plot(t,s,'-b');
grid on;
% plot(t,sd,'--k');
xlim([-10*T,10*T]);

%%
dF = Fs/length(s);
f = -Fs/2:dF:Fs/2-dF;
S = fftshift(fft(s));
%
figure
plot(f,abs(S));
grid on

%%
t = 0:0.01:8;
td = 3:8;
s = [600 360 1 1 360 600];
d = [td' s'];
y = pulstran(t,d,'sinc');
%
figure
plot(td,s,'o',t,y)
grid on








