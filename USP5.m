% main program saved as 'USP5.m'
bt = 1:1:3; 
v_W = 5:10:25; 
Pd = 'low';
S = 33;
T = 15; 
C = 1480; 
SL = 220; 
TS = -15; 
r_S = 0; 
z_S = 5; 
Zmax = 25; 
f = 100000; 
tau = 100e-6; 
B = 10e3; 
Thetah = deg2rad(0.5); 
Thetav = deg2rad(60);  
% Area
r1 = 20:1:600;
z1 = 0:1:50;
[r,z,Vw,bt] = ndgrid(r1,z1,v_W,bt);
% Distance 
RR = sqrt((r-r_S).^2+(z-z_S).^2);
% Transmission loss 
alpha = Atten_Schulkin_Marsh(f,S,T,Zmax).*(RR-1)./1000;
TL = 20.*log10(RR) + alpha;
% for isovelocity 
TLe = TL; 
TLb = TL;
TLs = TL;
TLv = TL;
% Isotropic Noise Level 
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
% Bottom reverberation strength 
Ab = Thetah.*RR.*C.*tau./cos(Thetab); 
Sb = Bottom_Reverberation(f,bt,Thetab);
RSb = Sb + 10.*log10(Ab);
% Surface reverberation strength 
As = Thetah.*RR.*C.*tau./cos(Thetas);
Ss = Surface_Reverberation(f,Vw,Thetas);
RSs = Ss + 10.*log10(As);
% Volume reverberation strength 
V = 2.*Thetah.*Thetav.*RR.^2.*C.*tau;
Sv = Volume_Reverberation(f,Pd);
RSv = Sv + 10.*log10(V);
% Directivity index 
DI = 40 - 10.*log10(Thetav*Thetah*180.^2./(pi.^2));
% SNR 
Rlb = SL+BPtb+BPrb-2.*TLb+RSb;
Rls = SL+BPts+BPrs-2.*TLs+RSs;
Rlv = SL-2.*TLv+RSv;
TIL = 10.*log10(10.^(0.1.*(NL-DI))+10.^(0.1.*Rlb)+ ...
    10.^(0.1.*Rls)+10.^(0.1.*Rlv));
SNR = SL+BPte+BPre-2.*TL+TS-(NL-DI)-TIL;
% Plot
set(0,'DefaultAxesFontSize',25)
figure(1);
CLIM = [0 35];
imagesc(r1,z1,SNR(:,:,1,1)',CLIM);
colormap(jet(256));
colorbar('vert');
title({'SN ( r, z )'; 'For bt = Mud and v_W = 5'});
xlabel('r [m]');
ylabel('Z [m]');
figure(2);
CLIM = [0 35];
imagesc(r1,z1,SNR(:,:,2,1)',CLIM);
colormap(jet(256));
colorbar('vert');
title({'SN ( r, z )'; 'For bt = Mud and v_W = 15'});
xlabel('r [m]');
ylabel('Z [m]');
figure(3);
CLIM = [0 35];
imagesc(r1,z1,SNR(:,:,3,1)',CLIM);
colormap(jet(256));
colorbar('vert');
title({'SN ( r, z )'; 'For bt = Mud and v_W = 25'});
xlabel('r [m]');
ylabel('Z [m]');
figure(4);
CLIM = [0 35]; 
imagesc(r1,z1,SNR(:,:,1,2)',CLIM);
colormap(jet(256));
colorbar('vert');
title({'SN ( r, z )'; 'For bt = Sand and v_W = 5'}); 
xlabel('r [m]');
ylabel('Z [m]');
figure(5);
CLIM = [0 35]; 
imagesc(r1,z1,SNR(:,:,2,2)',CLIM);
colormap(jet(256));
colorbar('vert');
title({'SN ( r, z )'; 'For bt = Sand and v_W = 15'}); 
xlabel('r [m]');
ylabel('Z [m]');
figure(6);
CLIM = [0 35]; 
imagesc(r1,z1,SNR(:,:,3,2)',CLIM);
colormap(jet(256));
colorbar('vert');
title({'SN ( r, z )'; 'For bt = Sand and v_W = 25'}); 
xlabel('r [m]');
ylabel('Z [m]');
figure(7);
CLIM = [0 35]; 
imagesc(r1,z1,SNR(:,:,1,3)',CLIM);
colormap(jet(256));
colorbar('vert');
title({'SN ( r, z )'; 'For bt = Gravel and v_W = 5'}); 
xlabel('r [m]');
ylabel('Z [m]');
figure(8);
CLIM = [0 35]; 
imagesc(r1,z1,SNR(:,:,2,3)',CLIM); 
colormap(jet(256));
colorbar('vert');
title({'SN ( r, z )'; 'For bt = Gravel and v_W = 15'}); 
xlabel('r [m]');
ylabel('Z [m]');
figure(9);
CLIM = [0 35];
imagesc(r1,z1,SNR(:,:,3,3)',CLIM);
colormap(jet(256));
colorbar('vert');
title({'SN ( r, z )'; 'For bt = Gravel and v_W = 25'}); 
xlabel('r [m]');
ylabel('Z [m]');


