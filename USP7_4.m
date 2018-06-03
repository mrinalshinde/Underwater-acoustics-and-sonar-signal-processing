stear1=-20; %steering angle in degrees
stear2=0;
stear3=20;
deg2rad=pi/180;
stang1=stear1*deg2rad;
stang2=stear2*deg2rad;
stang3=stear3*deg2rad;
R=30;
f=100000;
c=1480;
lamda=c/f;
d=lamda/2;
N=15;
n=0:N-1;
rho_deg=-90:0.01:90;
rho=rho_deg*deg2rad;
sinerho=sin(rho');
part2=2*pi*d*n/lamda;
Q=exp(j*sinerho*part2);
y1= exp(j*sin(stang1)*part2); %-40
B1=(Q*y1')/N;
y2= exp(j*sin(stang2)*part2); %0
B2=(Q*y2')/N;
y3=exp(j*sin(stang3)*part2); %20
B3=(Q*y3')/N;
gn1=20*log10(abs(B1));
gn2=20*log10(abs(B2));
gn3=20*log10(abs(B3));
figure(1);
plot(rho_deg,gn1,'linewidth',1.5');
hold on;
plot(rho_deg,gn2,'y','linewidth',1.5'); 
hold on;
plot(rho_deg,gn3,'m','linewidth',1.5'); 
hold on;
grid;
axis([-90 90 -60 15])
title('Beam pattern');
xlabel('Angle in degrees');
ylabel('Beam intensity in dB');
legend('stearing angle=-20°','stearing angle=0°','stearing angle=20°')
