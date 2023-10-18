clear
close all
clc
%
[X,Y] = meshgrid(-2:0.01:2.99);
Z = X + 1i*Y;
%
C   = [ 0.011306649026227244547726513701491057873
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
HZ = zeros(size(Z));
for i = 1:length(C)
    HZ = HZ + C(i)*Z.^(-i);
end

%
figure
mesh(X,Y,20*log10(abs(HZ)))
xlabel('X');
ylabel('Y');
zlabel('|H(z)|');
zlim([-100,10]);
title('АЧХ');
hold on;
%
cylinder
hold off;

%
figure
mesh(X,Y,angle(HZ))
xlabel('X');
ylabel('Y');
zlabel('arg(H(z))');
zlim([-pi,pi]);
title('ФЧХ');
hold on;
%
cylinder
hold off;
%%
Fs = 1;
dF = Fs/1000;
w = 2*pi*(0:dF:Fs-dF)';
z = exp(1i*w);
Hz = zeros(size(z));
for i = 1:length(C)
    Hz = Hz + C(i)*z.^(-i);
end
%
figure
plot(w,20*log10(abs(Hz)))
grid on

%%
N = 2;
n = 0:N-1;
F0 = Fs/N;
sig = cos(2*pi*F0*n/Fs);
%
subplot(2,1,1)
stem(sig);
grid on
subplot(2,1,2)
stem(out.simout);
grid on






