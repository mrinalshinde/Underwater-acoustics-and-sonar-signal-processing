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
for i = 1:9
   
    for j = 1:3
    CLIM = [0 35];
    imagesc(r1,z1,SNR(:,:,j,i)',CLIM);
    colormap(jet(256));
    colorbar('vert');
    xlabel('r [m]');
    ylabel('Z [m]');
    title(['bottom type = ',num2str(bt(j))])
    
    end
     figure(i)
end
    
