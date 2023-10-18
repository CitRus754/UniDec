clear
close all
clc
%
Fs0 = 44e6;
dt0 = 1/Fs0;
T = 1e-1;
N = Fs0*T;
t0 = (0:N-1)'*dt0;
%
sigma = 1/sqrt(2);
n = sigma*(randn(N,1) + 1i*randn(N,1));
%
F_vector = 1e6*(-19:19);
s = 0;
for i = 1:length(F_vector)
    s = s + exp(1i*2*pi*F_vector(i)*t0);
end
x = s + n;

%%
Mix1 = x.*exp(-1i*2*pi*10e6*t0);
%%
run('FIR_Coefs.m');

Dec11 = filter(C_11,1,Mix1);
Dec11 = Dec11(1:2:end);

Dec12 = filter(C_12,1,Dec11);
Dec12 = Dec12(1:2:end);

Fs1 = 11e6;

%%

Dec21 = filter(C_21,1,Dec12);
Dec21 = Dec21(1:2:end);

Dec22 = filter(C_22,1,Dec21);
Dec22 = Dec22(1:5:end);

Dec23 = filter(C_23,1,Dec22);
Dec23 = Dec23(1:5:end);
Fs2 = 220e3;

%%

Dec3 = filter(C_3,1,Dec23);
Dec3 = Dec3(1:2:end);

Fs3 = 110e3;

%%

Dec4 = filter(C_4,1,Dec3);
Dec4 = Dec4(1:2:end);

Fs4 = 55e3;

%%

Dec51 = filter(C_51,1,Dec4);
Dec51 = Dec51(1:2:end);

Dec52 = filter(C_52,1,Dec51);
Dec52 = Dec52(1:2:end);

Fs5 = 13.75e3;

%% spectrum
close all

figure
pwelch(x,880000,440000,880000,Fs0,'centered')
%
% figure
% pwelch(Mix1,880000,440000,880000,Fs0,'centered')
% 
% figure
% pwelch(Dec11,440000,220000,440000,Fs0/2,'centered')
% figure
% pwelch(Dec12,220000,110000,220000,Fs1,'centered')

%%
figure
pwelch(Dec21,110000,55000,110000,Fs1/2,'centered')
figure
pwelch(Dec22,22000,11000,22000,Fs1/10,'centered')
figure
pwelch(Dec23,4400,2200,4400,Fs2,'centered')

%%
figure
pwelch(Dec3,2200,1100,2200,Fs3,'centered')
%
figure
pwelch(Dec4,1100,550,1100,Fs4,'centered')

%%
figure
pwelch(Dec51,550,220,550,Fs4/2,'centered')
%
figure
pwelch(Dec52,220,110,220,Fs5,'centered')




