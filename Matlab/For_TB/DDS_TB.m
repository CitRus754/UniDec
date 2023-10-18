% This script is to calculate FCW to make desired DDS output frequency
clear
clc
%
Fclk = 44e6;
N = 24;
dF = Fclk/2^N;
%
Fout_desired    = 5e5;
FCW             = round(Fout_desired/Fclk*2^N);
Fout_real       = Fclk*FCW/2^N;
F_err = abs(Fout_real - Fout_desired);
%
FCW_fixed   = fi(FCW,0,8*ceil(N/8),0);
FCW_bin     = bin(FCW_fixed);
FCW_hex     = hex(FCW_fixed);

%%
% read data from file
fileID_1        = fopen('DDS_Cosine.txt', 'r');
fileID_2        = fopen('DDS_Sine.txt', 'r');

formatSpec      = '%d';
I_DDS_out        = fscanf(fileID_1,formatSpec);
I_DDS_out        = I_DDS_out/2046;

Q_DDS_out        = fscanf(fileID_2,formatSpec);
Q_DDS_out        = Q_DDS_out/2046;

fclose(fileID_1);
fclose(fileID_2);

%%
% plot signals
Fs = Fclk;
dt = 1/Fs;
L = length(I_DDS_out);
t = dt*(0:L-1)';
%
df = Fs/L;
f = -Fs/2:df:Fs/2-df;
DDS_out = I_DDS_out + 1i*Q_DDS_out;
DDS_Spectrum = fftshift(fft(DDS_out));
% time domain
% subplot(2,1,1)
% plot(t,I_Output);
% grid on;
% subplot(2,1,2)
% plot(t,Q_Output);
% grid on;
% freq domain
figure
plot(f,20*log10(abs(DDS_Spectrum)/L));
xlabel('f');
ylabel('Power(f), dB');
title('DDS Spectrum');
grid on






