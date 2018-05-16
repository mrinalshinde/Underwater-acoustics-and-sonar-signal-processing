% Given parameters
bt = 1:1:3; % bottomtype (mud,sand,gravel)
v_W = 5:10:25; % wind speed in m/s
Pd = 'low';
S = 33; % salinity in ppt
T = 15; % Temperature in degree
C = 1480; % velocity of sound in m/s
SL = 220; % [dB]rel 1uP @ 1m
TS = -15; % [dB]
r_S = 0; % [m]
z_S = 5; % [m]
Zmax = 25; % [m]
f = 100000; % [Hz]
tau = 100e-6; % [s]
B = 10e3; % [Hz]
Thetah = deg2rad(0.5); % [rad]
Thetav = deg2rad(60);  % [rad]
% Area
r1 = 20:1:600;
z1 = 0:1:50;
[r,z,Vw,bt] = ndgrid(r1,z1,v_W,bt);
% Distance (R) Calculation
RR = sqrt((r-r_S).^2+(z-z_S).^2);
% Transmission loss (TL)
alpha = Atten_Schulkin_Marsh(f,S,T,Zmax).*(RR-1)./1000;
TL = 20.*log10(RR) + alpha;
% for isovelocity (C=const.)
TLe = TL; TLb = TL;
TLs = TL; TLv = TL;
% Isotropic Noise Level (NL)
NL = Noise_Level(f,Vw);
NLb = NL + 10.*log10(B);
% Angles
Thetab = atan((Zmax-z_S)./sqrt(RR.^2-(Zmax-z_S).^2));
Thetas = atan(z_S./sqrt(RR.^2-(z_S).^2));
Thetae = atan((z-z_S)./(r-r_S));
% Bempattern values
BPtb = 10*log10(cos(Thetab));
BPrb = 10*log10(cos(Thetab));
BPts = 10*log10(cos(Thetas));
BPrs = 10*log10(cos(Thetas));
BPte = 10*log10(cos(Thetae));
BPre = 10*log10(cos(Thetae));
% Bottom reverberation strength (Rsb)
Ab = Thetah.*RR.*C.*tau./cos(Thetab); 
Sb = Bottom_Reverberation(f,bt,Thetab);
RSb = Sb + 10.*log10(Ab);
% Surface reverberation strength (Rss)
As = Thetah.*RR.*C.*tau./cos(Thetas);
Ss = Surface_Reverberation(f,Vw,Thetas);
RSs = Ss + 10.*log10(As);
% Volume reverberation strength (Rsv)
V = 2.*Thetah.*Thetav.*RR.^2.*C.*tau;
Sv = Volume_Reverberation(f,Pd);
RSv = Sv + 10.*log10(V);
% Directivity index (DI)
DI = 40 - 10.*log10(Thetav*Thetah*180.^2./(pi.^2));
% SNR Calculation
Rlb = SL+BPtb+BPrb-2.*TLb+RSb;
Rls = SL+BPts+BPrs-2.*TLs+RSs;
Rlv = SL-2.*TLv+RSv;
TIL = 10.*log10(10.^(0.1.*(NL-DI))+10.^(0.1.*Rlb)+ ...
    10.^(0.1.*Rls)+10.^(0.1.*Rlv));
SNR = SL+BPte+BPre-2.*TL+TS-(NL-DI)-TIL;
% Plot
figure(1);
CLIM = [0 35];
imagesc(r1,z1,SNR(:,:,1,1)',CLIM);
colormap(jet(256));
colorbar('vert');
title('SNR (Bottom type = mud and Vw = 5)');
xlabel('r [m]');
ylabel('Z [m]');
figure(2);
CLIM = [0 35];
imagesc(r1,z1,SNR(:,:,2,1)',CLIM);
colormap(jet(256));
colorbar('vert');
title('SNR (Bottom type = mud and Vw = 15)');
xlabel('r [m]');
ylabel('Z [m]');
figure(3);
CLIM = [0 35];
imagesc(r1,z1,SNR(:,:,3,1)',CLIM);
colormap(jet(256));
colorbar('vert');
title('SNR (Bottom type = mud and Vw = 25)');
xlabel('r [m]');
ylabel('Z [m]');
figure(4);
CLIM = [0 35]; imagesc(r1,z1,SNR(:,:,1,2)',CLIM);
colormap(jet(256));
colorbar('vert');
title('SNR (Bottom type = sand and Vw = 5)'); 
xlabel('r [m]');
ylabel('Z [m]');
figure(5);
CLIM = [0 35]; 
imagesc(r1,z1,SNR(:,:,2,2)',CLIM);
colormap(jet(256));
colorbar('vert');
title('SNR (Bottom type = sand and Vw = 15)');
xlabel('r [m]');
ylabel('Z [m]');
figure(6);
CLIM = [0 35]; imagesc(r1,z1,SNR(:,:,3,2)',CLIM);
colormap(jet(256));
colorbar('vert');
title('SNR (Bottom type = sand and Vw = 25)');
xlabel('r [m]');
ylabel('Z [m]');
figure(7);
CLIM = [0 35]; 
imagesc(r1,z1,SNR(:,:,1,3)',CLIM);
colormap(jet(256));
colorbar('vert');
title('SNR (Bottom type = gravel and Vw = 5)');
xlabel('r [m]');
ylabel('Z [m]');
figure(8);
CLIM = [0 35]; imagesc(r1,z1,SNR(:,:,2,3)',CLIM); 
colormap(jet(256));
colorbar('vert');
title('SNR (Bottom type = gravel and Vw = 15)');
xlabel('r [m]');
ylabel('Z [m]');
figure(9);
CLIM = [0 35]; imagesc(r1,z1,SNR(:,:,3,3)',CLIM);
colormap(jet(256));
colorbar('vert');
title('SNR (Bottom type = gravel and Vw = 25)');
xlabel('r [m]');
ylabel('Z [m]');


function [Sv] = Volume_Reverberation(f,Pd)
f = f./1000; 
if Pd == '1'
    SP = -50;
else if Pd == '0.5'
        SP = -70;
else
SP = -90;
end
end
Sv = SP+7.*log10(f);
end


function [Sb] = Bottom_Reverberation(f,bt,g)
f = f./1000;
% SEARAY Model "Bottom reverberation"
k = 1+125.*exp(-2.64.*(bt-1.75).^2-50./bt.*(cot(g)).^2); 
b = k.*(sin(g)+0.19).^(bt.*(cos(g)).^16);
Sb = 10.*log10(3.03.*b.*(f.^(3.2-0.8.*bt).* ...
    10.^(2.8.*bt-12)+10.^(-4.42)));
end

function [Ss] = Surface_Reverberation(f,Vw,g)
f = f./1000;
% Surface reverberation coefficient
b = (4.*(Vw+2)./(Vw+1))+(2.5.*(f+0.1).^(-1./3)-4).* ...
    (abs(cos(g))).^(1/8);
Ss = 10.*log10(10.^(-5.05).*(1+Vw).^2.*(f+0.1).^(Vw./150).* ...
    (tan(g)).^(b));
end

function [A] = Atten_Schulkin_Marsh(f,S,T,Zmax) % Global parameters
A = 2.34e-6;
B = 3.38e-6;
f = f./1000;
% Schulkin & Marsh, 3kHz - 0.5Mhz
ft = 21.9.*10.^(6-(1520./(T+273)));
P = 1.01.*(1+Zmax.*0.1);
A = 8.686e3.*((S.*A.*ft.*f.^2)./(ft^2+f.^2)+(B.*f.^2)./(ft)) ...
    *(1-6.54e-4.*P);
end

function NL = Noise_Level(f,Vw)
f = f./1000;
% Shipping noise (traffic)
NLTraffic = 10.*log10(3e8./(1+1e4.*f.^4)); % Turbuleance noise
NLTurb = 30-30.*log10(f);
% Self noise of sonar platform (vessel)
NLVessel = -999;
% Biological noise (fishes, scrimps, etc.)
NLBio = -999;
% Sea state noise
NLSS = 40+10.*log10(Vw.^2./(1+f.^(5/3)));
% Thermal noise
NLThermal = -15+20.*log10(f);
% Total isotropic noise level
NL = 10.*log10(10.^(0.1.*NLTraffic)+10.^(0.1.*NLTurb)+10.^ ...
    (0.1.*NLVessel)+10.^(0.1.*NLBio)+10.^(0.1.*NLSS)+10.^ ...
    (0.1.* NLThermal));
end
