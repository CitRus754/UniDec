%% plot several half-band FIR response replicas
close all
%
Fs = 27.5e3;          % input Fs
W = 6.25e3;          % output W
NFFT = 4096;
D = 2;
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

% C = [-0.001441574184935712731048251811216687202
%     -0.005004831254517739733134185087237710832
%     -0.01010139453018881611212620441619947087 
%     -0.015892208200230888842652277048728137743
%     -0.01834069542846544775827055673289578408 
%     -0.013359117467352077390785325405886396766
%      0.003443905175664271033075802819212185568
%      0.033250700807846853002125442344549810514
%      0.073510965648995285626199347461806610227
%      0.117027285265357355870108335693657863885
%      0.154182025421199547787765027351269964129
%      0.17559414240753892788582390949159162119 
%      0.17559414240753892788582390949159162119 
%      0.154182025421199547787765027351269964129
%      0.117027285265357355870108335693657863885
%      0.073510965648995285626199347461806610227
%      0.033250700807846853002125442344549810514
%      0.003443905175664271033075802819212185568
%     -0.013359117467352077390785325405886396766
%     -0.01834069542846544775827055673289578408 
%     -0.015892208200230888842652277048728137743
%     -0.01010139453018881611212620441619947087 
%     -0.005004831254517739733134185087237710832
%     -0.001441574184935712731048251811216687202
%     ];

[H,f] = freqz(C,1,NFFT,'whole',Fs);
%
figure;
plot(f-Fs/2,20*log10(abs(fftshift(H))),'b-','LineWidth',2)
grid on
hold on
plot(f-Fs/2+Fs/D,20*log10(abs(fftshift(H))),'b--')
plot(f-Fs/2-Fs/D,20*log10(abs(fftshift(H))),'b--')
plot(f-Fs/2+2*Fs/D,20*log10(abs(fftshift(H))),'b--')
plot(f-Fs/2-2*Fs/D,20*log10(abs(fftshift(H))),'b--')

% plot result spectrum in -Fs/2:Fs/2 band
% ResSpectrum = 10*log10(abs(H).^2 + abs(fftshift(H)).^2);
% plot(f-Fs/2,ResSpectrum,'r-','LineWidth',2)
%

xline(-W/2,'-r','-W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xline(W/2,'-r','W/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','top');
xline(-Fs/2,'--k','-Fs/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','bottom');
xline(Fs/2,'--k','Fs/2','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','bottom');
xline(-Fs/(2*D),'--k','-Fs/2D','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','bottom');
xline(Fs/(2*D),'--k','Fs/2D','LabelOrientation','horizontal',...
    'LabelHorizontalAlignment','center','LabelVerticalAlignment','bottom');
% legend('Baseband spectrum', ...
%     'First positive replica', 'First negative replica', ...
%     'Second positive replica', 'Second negative replica')
xlim([-Fs/2,Fs/2]);
title('Aliasing with half-band filter');
fig = gcf;
fig.Color = 'White';
hold off

%%
ResSpectrum = zeros(size(H));
for i = 1:length(H)
    ResSpectrum(i) = 10*log10(abs(fftshift(H(i)))^2 + abs(H(i))^2);
end








