clear
close all
clc
%
Fs  = 44e6;
dt  = 1/Fs;
N   = 1e5;
t   = dt*(0:N-1)';

% form signal
Npulses     = 100;
sigma       = 0;
w0          = 2*pi*1e6;     % carrier

% sr_period   = [ones(Npulses,1);zeros(900,1)];
% sr_period   = ones(N,1);
% sr          = repmat(sr_period,100,1);
sr          = ones(N,1).*cos(w0*t) + sigma*randn(size(t));	% real signal

sa          = hilbert(sr);                             	% analytic signal

%% write input signal to files
% sa_int    - integer version of sa:    (1,16,0) fp-format
% sa_r      - real version of sa:       (1,16,15) fp-format
multer  = 2^14;
sa_int  = floor(multer*sa);     % it goes to Vivado

% overflow check
if max(real(sa_int)) >= 2^15-1 || max(imag(sa_int)) >= 2^15-1 ...
        || min(real(sa_int)) <= -2^15 || min(imag(sa_int)) <= -2^15
   error('Input Overflow!'); 
end

% delayed version of sa_int; Tdelay = 1 clock cycle
sa_int_d  = [0;sa_int(1:end-1)];  % zero padding to compensate Vivado delay
sa_r    = sa_int_d/2^15;

%% write to files
filename1	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Input_I.txt';
filename2	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Input_Q.txt';
writematrix(real(sa_int),filename1);
writematrix(imag(sa_int),filename2);

clear filename1 filename2 multer

%% Debug read
% read data from file
% filename1	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\DDS\DDS_Cos.txt';
% filename2	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\DDS\DDS_Sin.txt';
% filename1	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Mix\Mix_I.txt';
% filename2	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Mix\Mix_Q.txt';
filename1	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\St2Ch7_I.txt';
filename2	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\St2Ch7_Q.txt';
fileID_1    = fopen(filename1, 'r');
fileID_2    = fopen(filename2, 'r');

formatSpec      = '%d';
dbg_i        = fscanf(fileID_1,formatSpec);
dbg_q        = fscanf(fileID_2,formatSpec);

fclose(fileID_1);
fclose(fileID_2);
clear filename1 filename2 fileID_1 fileID_2 formatSpec

dbg_int = dbg_i + 1i*dbg_q;     % (1,16,0)
dbg_r   = dbg_int/2^15;         % (1,16,15)

%% Mixer
% mix_fr    - mixer full range signal (without truncating)
mix_fr = sa_int_d.*dds_int;

mix_int = round(mix_fr/2^11);   % (1,16,0)

% zero padding to compare with Vivado; Tdelay = 4 clock cycles
mix_int = [0;0;0;0;mix_int(1:end-4)];
mix_r   = mix_int/2^15;         % (1,16,15)

%% read output signals from files
% read mixer signal
filename1	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Mixer_I.txt';
filename2	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Mixer_Q.txt';
fileID_1    = fopen(filename1, 'r');
fileID_2    = fopen(filename2, 'r');

% prefix v means Vivado
formatSpec    = '%d';
vMix_I        = fscanf(fileID_1,formatSpec);
vMix_Q        = fscanf(fileID_2,formatSpec);
%%
fclose(fileID_1);
fclose(fileID_2);
clear filename1 filename2 fileID_1 fileID_2 formatSpec

vMix_int = vMix_I + 1i*vMix_Q;
vMix_r   = vMix_int/2^15;

% check errors
Err_I = abs(real(mix_int) - real(vMix_int));
maxErr_I = max(Err_I);

Err_Q = abs(imag(mix_int) - imag(vMix_int));
maxErr_Q = max(Err_Q);

%% plots
close all
% time domain
% sa
figure
gr = 1:2e3;     % graphic range
plot3(t(gr),real(sa(gr)),imag(sa(gr)));
grid on;
xlabel('t');
ylabel('real(sa)');
zlabel('imag(sa)');
title('Input Signal');

%% dds
figure
gr = 1:1000;     % graphic range
plot3(t(gr),real(dds_int(gr)),imag(dds_int(gr)));
grid on;
xlabel('t');
ylabel('real(dds)');
zlabel('imag(dds)');
title('DDS');

% mix
figure
gr = 1:1000;     % graphic range
plot3(t(gr),real(vMix_int(gr)),imag(vMix_int(gr)));
grid on;
xlabel('t');
ylabel('real(mix)');
zlabel('imag(mix)');
title('Mixer');

%%
close all
% freq domain
dF = Fs/N;
f = dF*(-N/2:N/2-1);
%
Din_Spectrum    = fftshift(fft(sa_int));
DBG_Spectrum    = fftshift(fft(dbg_int(87:end)));
% Mix_Spectrum    = fftshift(fft(mix_int));
% vMix_Spectrum   = fftshift(fft(vMix_int));
%
figure
plot(f,20*log10(abs(Din_Spectrum/N)));
grid on;
xlabel('f');
ylabel('Power, dB');
xlim([-Fs/2;Fs/2-dF]);
% ylim([-90,10]);
title('Input Signal');
%
figure
L = length(DBG_Spectrum);
plot((Fs/4)/L*(-L/2:L/2-1),20*log10(abs(DBG_Spectrum/L)));
grid on;
xlabel('f');
ylabel('Power, dB');
xlim([-(Fs/4)/2;(Fs/4)/2-(Fs/4)/L]);
% ylim([-90,10]);
title('debug');
%%
figure
plot(f,20*log10(abs(Mix_Spectrum/N)));
grid on;
xlabel('f');
ylabel('Power, dB');
xlim([-Fs/2;Fs/2-dF]);
ylim([-100,100]);
title('Mixer Out');

%
figure
plot(f,20*log10(abs(vMix_Spectrum/N)));
grid on;
xlabel('f');
ylabel('Power, dB');
xlim([-Fs/2;Fs/2-dF]);
ylim([-100,100]);
title('Vivado Mixer Out');

%%
f0 = 1e3*(900:-100:200);
T0 = 1./f0;
n = 0:7;
T_arr = [n;T0];





