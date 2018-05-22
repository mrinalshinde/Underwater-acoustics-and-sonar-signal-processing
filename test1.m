A = 1; % Amplitude
f = [10,100,1000,10000,100000]; % Frequency [Hz]
D = 20; % Water depth [m]
r_S = 0; % Source location
z_S = 5; % Source location
r_R = 0:500; % Receiver location
z_R = 0:0.1:D; % Receiver location
R_2 = 1; % Hard bottom type
c = 1480; % Sound speed
lambda = c./f; % Wavelength
omega = 2.*pi.*f; % Angular frequency
[z_r,r_r] = ndgrid(z_R,r_R);
for p = 1:5
for m = 0:5
L1 = sqrt(r_r.^2+(2.*D.*m-z_S+z_r).^2);
L2 = sqrt(r_r.^2+(2.*D.*m+z_S+z_r).^2);
L3 = sqrt(r_r.^2+(2.*D.*(m+1)-z_S-z_r).^2);
L4 = sqrt(r_r.^2+(2.*D.*(m+1)+z_S-z_r).^2);
%Computation of Pressure
P(:,:,2) = A.*((-1)^m.*(exp(-1j.*omega(p).*L1)./L1...
-exp(-1j.*omega(p).*L2)./L2+exp(-1j.*omega(p).*L3)./L3...
-exp(-1j.*omega(p).*L4)./L4));
P = sum(P,3);
Pr(:,:,p) = P;
end
CLIM = [-50 10];
set(0,'DefaultAxesFontSize',27)
figure(p)
imagesc(r_R,z_R,10.*log10(abs(Pr(:,:,p))),CLIM);
colorbar('vert');
xlabel('R [m]');
ylabel('Z [m]');
title(strcat('Frequency = ',num2str(10.^p),'Hz(at rs=0m,zs=5m)'));
end