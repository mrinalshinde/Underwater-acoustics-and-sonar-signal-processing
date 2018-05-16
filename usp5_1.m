rm = 50:600; 
bt = 1:3; %Bottom type:mud;sand;gravel 
v = 5:10:25; 
S = 33; %[ppt] 
T = 15; %[degree] 
C = 1480; %[m/s] 
SL = 220; %[dB] rel 1uP @ 1m 
f = 100; %kHz 
tau = 100e-6; %[s] 
B = 1000; %Bandwidth in [Hz] 
rs = 0; zs = 5; 
DI = 30; %[dB] 
TS = -15; %[dB] 
Zmax = 50; zm = 0:50; %[m] 
a = 2.34e-6; 
b = 3.38e-6; 
theta_hR = deg2rad(0.5); %[rad] 
theta_vT = deg2rad(180); %[rad] 
[r,z,vw,bt] = ndgrid(rm,zm,v,bt); 
%Distance R 
R = sqrt(((r-rs).^2)+(z-zs).^2); 
%Grazing angle 
theta_b = atan((Zmax-zs)./sqrt(R.^2-((Zmax-zs).^2))); 
theta_s = atan(zs./sqrt(R.^2-(zs).^2)); 
theta_v = theta_b + theta_s; 
%Isotropic noise level 
N_turb = 30-30.*log10(f); % Turbulence Noise level 
N_traffic = 10.*log10((3.*10.^8)./(1+(10.^4).*(f.^4))); % traffic NL 
N_state = 40+10.*log10((vw.^2)./(1+f.^(5./3))); %Sea State NL 
N_therm = -15+20.*log10(f); % Thermal NL 
N_rain = -999; %rain NL 
N_bio = -999; %Biological NL

N_vessel = -999; % seaVessel NL 
Isotropic_NL = 10.*log10((10.^(0.1.*N_traffic)) + (10.^(0.1.*N_turb)) + (10.^(0.1.*N_state)) + (10.^(0.1.*N_therm)) + (10.^(0.1.*N_rain)) + (10.^(0.1.*N_bio)) + (10.^(0.1.*N_vessel))); 
NLB = Isotropic_NL + 10.*log10(B); 
%Surface reverberation strength RSs 
beta_s = 4.*((vw+2)./(vw+1))+(2.5*((f+0.1)^(-1./3))-4).*cos(theta_s).^(1/8); 
S_s = 10.*log10(((tan(theta_s)).^beta_s).*((1+vw).^2).*((f+0.1).^(vw/150)).*(10.^(-5.05))); 
AS = theta_hR.*R.*C.*tau./(2*cos(theta_s)); 
RSS = S_s + 10.*log10(AS); 
%Bottom reverberation strength RSb 
R = 1+125.*exp(-2.64.*((bt-1.75).^2)-(50./bt).*(cot(theta_b)).^2); 
beta_b = R.*(sin(theta_b) +0.19).^(bt.*cos(theta_b).^16); 
S_b = 10.*log10(3.03.*beta_b.*f.^(3.2-0.8.*bt).*10.^(2.8.*bt-12) + 10^(-4.42)); 
AB = theta_hR.*R.*C.*tau./(2*cos(theta_b)); 
RSB = S_b+10.*log10(AB); 
%Volume reverberation strength RSv 
Sv = -70+7.*log10(f); 
V = C.*tau.*0.5.*theta_hR.*theta_vT.*R.^2; 
RSV = Sv+10.*log10(V); 
%Transmission loss 
ft = 21.9*(10.^(6-1520./(T+273))); 
p = 1.01*(1+Zmax*0.1); 
alpha = 8.686e3*(((S.*a.*(f.^2).*ft)./(ft.^2+f.^2))+(b.*f.^2/ft)).*(1-6.54e-4.*p); 
TLE = 20.*log10(R)+alpha.*(R-1)./1000; 
%For isovelocity 
TLB = TLE; 
TLS = TLE; 
TLV = TLE; 
RLB = SL-2.*TLB+RSB; %Reverberation level of bottom 
RLS = SL-2.*TLS+RSS; %Reverberation level of surface 
RLV = SL-2.*TLV+RSV; %Reverberation level of volume 
TIL = 10.*log10((10.^(0.1.*(NLB-DI)))+(10.^(0.1.*RLB))+(10.^(0.1.^RLS))+(10.^(.1.*RLV)));%Total interference level 
SNR = SL-2.*TLE+TS-TIL; 
figure(1); 
caxis([0 35]); 
imagesc(rm,zm,SNR(:,:,1,1)',caxis);
colormap(jet(256));
colorbar('vert'); 
title('SNR(Vw=5 Kn,bottom type=mud)'); 
xlabel('r[m]'); 
ylabel('z[m]'); 
figure(2); 
caxis([0 35]); 
imagesc(rm,zm,SNR(:,:,2,1)',caxis); 
colormap(jet(256));
colorbar('vert'); 
title('SNR(Vw=15 Kn,bottom type=mud)'); 
xlabel('r[m]'); 
ylabel('z[m]'); 
figure(3);
caxis([0 35]); 
imagesc(rm,zm,SNR(:,:,3,1)',caxis); 
colormap(jet(256));
colorbar('vert'); 
title('SNR(Vw=25 Kn,bottom type=mud)'); 
xlabel('r[m]'); 
ylabel('z[m]'); 
figure(4); 
caxis([0 35]); 
imagesc(rm,zm,SNR(:,:,1,2)',caxis); 
colormap(jet(256));
colorbar('vert'); 
title('SNR(Vw=5 Kn,bottom type=sand)'); 
xlabel('r[m]'); 
ylabel('z[m]'); 
figure(5); 
caxis([0 35]); 
imagesc(rm,zm,SNR(:,:,2,2)',caxis); 
colormap(jet(256));
colorbar('vert'); 
title('SNR(Vw=15 Kn,bottom type=sand)'); 
xlabel('r[m]'); 
ylabel('z[m]'); 
figure(6); 
caxis([0 35]); 
imagesc(rm,zm,SNR(:,:,3,2)',caxis); 
colormap(jet(256));
colorbar('vert'); 
title('SNR(Vw=25 Kn,bottom type=sand)'); 
xlabel('r[m]'); 
ylabel('z[m]'); 
figure(7); 
caxis([0 35]); 
imagesc(rm,zm,SNR(:,:,1,3)',caxis); 
colormap(jet(256));
colorbar('vert'); 
title('SNR(Vw=5 Kn,bottom type=gravel)'); 
xlabel('r[m]'); 
ylabel('z[m]'); 
figure(8); 
caxis([0 35]); 
imagesc(rm,zm,SNR(:,:,2,3)',caxis);
colormap(jet(256));
colorbar('vert'); 
title('SNR(Vw=15 Kn,bottom type=gravel)'); 
xlabel('r[m]'); 
ylabel('z[m]'); 
figure(9); 
caxis([0 35]); 
imagesc(rm,zm,SNR(:,:,3,3)',caxis); 
colormap(jet(256));
colorbar('vert'); 
title('SNR(Vw=25 Kn,bottom type=gravel)'); 
xlabel('r[m]'); 
ylabel('z[m]');