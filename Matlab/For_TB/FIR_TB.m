clear
close all
clc
%
Fs  = 44e6;
dt  = 1/Fs;
N   = 1e6;
t   = dt*(0:N-1)';
T = N*dt;

% form signal
tau = 0.2e-6;
Npulses = 2;
Tpulses = 1e-3;
%
sr_period = [ones(Npulses,1);zeros(4999*Npulses,1)];
sr = repmat(sr_period,100,1);
%
sa1 = hilbert(sr).*exp(-1i*2*pi*10e6*t);
sa2 = hilbert(sr).*exp(-1i*2*pi*15e6*t);

%
inp_I_1 = real(sa1);
inp_I_2 = real(sa2);
inp_Q_1 = imag(sa1);
inp_Q_2 = imag(sa2);

%% write input signal to files
% sa_int    - integer version of sa:    (1,16,0) fp-format
% sa_r      - real version of sa:       (1,16,15) fp-format
multer  = 2^14;
sa_int_1  = floor(multer*sa1);     % it goes to Vivado
sa_r_1    = sa_int_1/2^15;

sa_int_2  = floor(multer*sa2);     % it goes to Vivado
sa_r_2    = sa_int_2/2^15;

% overflow check
if max(real(sa_int_1)) >= 2^15-1 || max(imag(sa_int_1)) >= 2^15-1 ...
        || min(real(sa_int_1)) <= -2^15 || min(imag(sa_int_1)) <= -2^15
   error('sa1 overflow!'); 
end

if max(real(sa_int_2)) >= 2^15-1 || max(imag(sa_int_2)) >= 2^15-1 ...
        || min(real(sa_int_2)) <= -2^15 || min(imag(sa_int_2)) <= -2^15
   error('sa2 overflow!'); 
end

%% write to files
filename1	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\inp_I_1.txt';
filename2	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\inp_I_2.txt';
filename3	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\inp_Q_1.txt';
filename4	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\inp_Q_2.txt';

writematrix(real(sa_int_1),filename1);
writematrix(real(sa_int_2),filename2);
writematrix(imag(sa_int_1),filename3);
writematrix(imag(sa_int_2),filename4);

clear filename1 filename2 filename3 filename4 multer

%% FIR
D = 2;
W = 10e6;   % signal BW
%
C = [0.011306649026227244547726513701491057873
     0                                        
    -0.061053507687467117870383503941411618143
     0                                        
     0.300170216623796559662906702214968390763
     0.5                                      
     0.300170216623796559662906702214968390763
     0                                        
    -0.061053507687467117870383503941411618143
     0                                        
     0.011306649026227244547726513701491057873
    ];
%
% if you want to check for FIR response, use FIR_plots.m script
% there you'll see aliasing and so on
fir_I_1     = filter(C,1,inp_I_1);
fir_I_2     = filter(C,1,inp_I_2);
fir_Q_1     = filter(C,1,inp_Q_1);
fir_Q_2     = filter(C,1,inp_Q_2);

fir_int_1   = filter(C,1,sa_int_1)/2;
fir_r_1     = fir_int_1/2^14;

fir_int_2   = filter(C,1,sa_int_2)/2;
fir_r_2     = fir_int_2/2^14;

%
fir_1   = fir_I_1 + 1i*fir_Q_1;
fir_2   = fir_I_2 + 1i*fir_Q_2;

% decimation
dec_I_1     = fir_I_1(1:D:end);
dec_I_2     = fir_I_2(2:D:end);
dec_Q_1     = fir_Q_1(1:D:end);
dec_Q_2     = fir_Q_2(2:D:end);

dec_int_1   = fir_int_1(1:D:end);
dec_r_1     = dec_int_1/2^14;

dec_int_2   = fir_int_2(2:D:end);
dec_r_2     = dec_int_2/2^14;

%
dec_1   = dec_I_1 + 1i*dec_Q_1;
dec_2   = dec_I_2 + 1i*dec_Q_2;

%
N2  = length(dec_I_1);
Fs2 = Fs/D;
dF2 = Fs2/N2;
f2 = dF2*(-N2/2:N2/2-1);


%% read output signals from files
% read mixer signal
filename1	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\outp_I_1.txt';
filename2	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\outp_I_2.txt';
filename3	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\outp_Q_1.txt';
filename4	= 'E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\outp_Q_2.txt';

fileID_1    = fopen(filename1, 'r');
fileID_2    = fopen(filename2, 'r');
fileID_3    = fopen(filename3, 'r');
fileID_4    = fopen(filename4, 'r');

% prefix v means Vivado
formatSpec    = '%d';
vFir_I_1      = fscanf(fileID_1,formatSpec);
vFir_I_2      = fscanf(fileID_2,formatSpec);
vFir_Q_1      = fscanf(fileID_3,formatSpec);
vFir_Q_2      = fscanf(fileID_4,formatSpec);
L = length(vFir_I_1);
rg = 1:L;

fclose(fileID_1);
fclose(fileID_2);
fclose(fileID_3);
fclose(fileID_4);
clear filename1 filename2 filename3 filename4 fileID_1 fileID_2 fileID_3 fileID_4

% vFir_int_1 = vFir_I_1 + 1i*vFir_Q_1;
% vFir_int_2 = vFir_I_2 + 1i*vFir_Q_2;

% check errors
% zero pads into input signals
dec_int_1 = [0;0;0;dec_int_1(1:end-3)];
dec_int_2 = [0;0;0;dec_int_2(1:end-3)];

Err_I_1 = abs(real(dec_int_1(rg)) - vFir_I_1);
Err_I_2 = abs(real(dec_int_2(rg)) - vFir_I_2);
Err_Q_1 = abs(imag(dec_int_1(rg)) - vFir_Q_1);
Err_Q_2 = abs(imag(dec_int_2(rg)) - vFir_Q_2);

maxErr_I_1 = max(Err_I_1);
maxErr_I_2 = max(Err_I_2);
maxErr_Q_1 = max(Err_Q_1);
maxErr_Q_2 = max(Err_Q_2);


%% plots
close all
% time domain
% sa1
figure
gr = 1:2e4;     % graphic range
plot3(t(gr),real(sa1(gr)),imag(sa1(gr)));
grid on;
xlabel('t');
ylabel('real(sa1)');
zlabel('imag(sa1)');
title('sa1');

% sa2
figure
gr = 1:1e3;     % graphic range
plot3(t(gr),real(sa2(gr)),imag(sa2(gr)));
grid on;
xlabel('t');
ylabel('real(sa2)');
zlabel('imag(sa2)');
title('sa2');

%%
close all
% freq domain
dF = Fs/N;
f = dF*(-N/2:N/2-1);
%
Din_Spectrum_1    = fftshift(fft(sa1));
Din_Spectrum_2    = fftshift(fft(sa2));

FIR_Spectrum_1    = fftshift(fft(fir_1));
FIR_Spectrum_2    = fftshift(fft(fir_2));

Dec_Spectrum_1    = fftshift(fft(dec_1));
Dec_Spectrum_2    = fftshift(fft(dec_2));

%
figure
plot(f,20*log10(abs(Din_Spectrum_1/N)));
grid on
hold on
% plot +-W/2 lines of signal BW
xline(-W/2,'-r','-W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xline(W/2,'-r','W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xlabel('f');
ylabel('Power, dB');
xlim([-Fs/2;Fs/2-dF]);
ylim([-70,10]);
title('sa1');
hold off;

%
figure
plot(f,20*log10(abs(Din_Spectrum_2/N)));
grid on
hold on
% plot +-W/2 lines of signal BW
xline(-W/2,'-r','-W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xline(W/2,'-r','W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xlabel('f');
ylabel('Power, dB');
xlim([-Fs/2;Fs/2-dF]);
ylim([-70,10]);
title('sa2');
hold off;

%
figure
plot(f,20*log10(abs(FIR_Spectrum_1/N)));
grid on
hold on
%
xline(-W/2,'-r','-W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xline(W/2,'-r','W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');

xlabel('f');
ylabel('Power, dB');
xlim([-Fs/2;Fs/2-dF]);
ylim([-70,10]);
title('fir1');
hold off;

%
figure
plot(f,20*log10(abs(FIR_Spectrum_2/N)));
grid on
hold on
%
xline(-W/2,'-r','-W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xline(W/2,'-r','W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');

xlabel('f');
ylabel('Power, dB');
xlim([-Fs/2;Fs/2-dF]);
ylim([-70,10]);
title('fir2');
hold off;


%
figure
plot(f2,20*log10(abs(Dec_Spectrum_1/N2)));
grid on
hold on
%
xline(-W/2,'-r','-W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xline(W/2,'-r','W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');

xlabel('f');
ylabel('Power, dB');
xlim([-Fs2/2;Fs2/2-dF2]);
ylim([-70,10]);
title('dec1');
hold off;

%
figure
plot(f2,20*log10(abs(Dec_Spectrum_2/N2)));
grid on
hold on
%
xline(-W/2,'-r','-W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xline(W/2,'-r','W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');

xlabel('f');
ylabel('Power, dB');
xlim([-Fs2/2;Fs2/2-dF2]);
ylim([-70,10]);
title('dec2');
hold off;

