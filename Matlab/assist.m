clear
close all
clc
%
[X,Y] = meshgrid(-2:0.02:1.99);
Z = X + 1i*Y;
Hz = Z.^(-1)./(1-Z.^(-1));
%
figure
mesh(X,Y,abs(Hz))
xlabel('X');
ylabel('Y');
zlabel('|H(z)|');
zlim([0,5]);
title('АЧХ');
hold on;
%
cylinder

