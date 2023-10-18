%%
% fix it!
clear
close all
clc
% initial parameters
BW0 = 20e6;
Fs0 = 44e6;
dt0 = 1/Fs0;
N0  = 4e6;
t0  = dt0*(0:N0-1)';
dF0 = Fs0/N0;
f0  = dF0*(-N0/2:N0/2-1)';
D   = [2 2 2 5 5 2 2 2 2];
%
Fs  = [Fs0;zeros(length(D),1)];
BW  = [BW0;zeros(length(D),1)];
dF  = [dF0;zeros(length(D),1)];
N   = [N0;zeros(length(D),1)];

for i = 2:length(Fs)
    Fs(i) = Fs(i-1)/D(i-1);
    BW(i) = BW(i-1)/D(i-1);
    dF(i) = dF(i-1);
    N(i)  = N(i-1)/D(i-1);
end
BW(1) = 40e6;     % fix
% form signal
tau = 0.2e-6;
Npulses = 2;
Tpulses = 1e-3;
%
sr_period = [ones(Npulses,1);zeros(4999*Npulses,1)];
sr = repmat(sr_period,400,1);
sa = hilbert(5e3*sr).*exp(-1i*2*pi*10e6*t0);

%% create cell-arrays
dt  = 1./Fs;

C2 =    [0.011306649026227244547726513701491057873
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
C5 =   [-0.001441574184935712731048251811216687202
        -0.005004831254517739733134185087237710832
        -0.01010139453018881611212620441619947087 
        -0.015892208200230888842652277048728137743
        -0.01834069542846544775827055673289578408 
        -0.013359117467352077390785325405886396766
         0.003443905175664271033075802819212185568
         0.033250700807846853002125442344549810514
         0.073510965648995285626199347461806610227
         0.117027285265357355870108335693657863885
         0.154182025421199547787765027351269964129
         0.17559414240753892788582390949159162119 
         0.17559414240753892788582390949159162119 
         0.154182025421199547787765027351269964129
         0.117027285265357355870108335693657863885
         0.073510965648995285626199347461806610227
         0.033250700807846853002125442344549810514
         0.003443905175664271033075802819212185568
        -0.013359117467352077390785325405886396766
        -0.01834069542846544775827055673289578408 
        -0.015892208200230888842652277048728137743
        -0.01010139453018881611212620441619947087 
        -0.005004831254517739733134185087237710832
        -0.001441574184935712731048251811216687202
        ];

TimeArr         = cell(10,1);
TimeArr{1,1}      = t0;

FreqArr         = cell(10,1);
FreqArr{1,1}      = f0;

Signals         = cell(10,1);
Signals{1,1}      = sa;

Spectrums       = cell(10,1);
Spectrums{1,1}    = fftshift(fft(Signals{1,1}));

for i = 2:10
    TimeArr{i,1} = dt(i)*(0:N(i)-1)';
    FreqArr{i,1} = dF(i)*(-N(i)/2:N(i)/2-1)';
    if i == 4 || i ==5                          % for these indexes use D=5
        Signals{i,1} = filter(C5,1,Signals{i-1,1});
    else
        Signals{i,1} = filter(C2,1,Signals{i-1,1});
    end
    Signals{i,1}      = Signals{i,1}(1:D(i-1):end);
    Spectrums{i,1}    = fftshift(fft(Signals{i,1}));
end

%% plots
close all
% freq domain

k = 10;
figure
plot(FreqArr{k,1},20*log10(abs(Spectrums{k,1})));
grid on
hold on
% plot +-W/2 lines of signal BW
xline(-BW(k)/2,'-r','-W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xline(BW(k)/2,'-r','W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xlabel('f');
ylabel('Power, dB');
xlim([-Fs(k)/2;Fs(k)/2-dF(k)]);
% ylim([-70,10]);
hold off;

% next processing
SpOut = Spectrums{k,1}(find(abs(FreqArr{k,1})-Fs(k)/4 < 1e-3));
SigOut = ifftshift(ifft(SpOut));
%
figure
plot3(dt(k)*(0:length(SigOut)-1),real(SigOut),imag(SigOut));
grid on;
xlabel('t');
ylabel('real(s2)');
zlabel('imag(s2)');
title('Output Signal');

%%
close all
% time domain
% sa
k = 1;
figure
% gr = 1:1e5;     % graphic range
plot3(TimeArr{k,1},real(Signals{k,1}),imag(Signals{k,1}));
grid on;
xlabel('t');
ylabel('real(sa)');
zlabel('imag(sa)');
title('Input Signal');









