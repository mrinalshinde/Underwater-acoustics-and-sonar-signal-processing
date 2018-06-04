stear_1 = -20; % steering angle in degrees
stear_2 = 0;
stear_3 = 20;
deg2rad = pi/180;
stear1 = stear_1*deg2rad;
stear2 = stear_2*deg2rad;
stear3 = stear_3*deg2rad;
R = 30;
f = 100000;
c = 1480;
lamda = c/f;
d = lamda/2;
N = 15;
n = 0:N-1;
rho_deg = -90:0.01:90;
rho_rad = rho_deg*deg2rad;
sinerho = sin(rho_rad');
part2 = 2*pi*d*n/lamda;
Q = exp(1i*sinerho*part2);
y1 = exp(1i*sin(stear1)*part2); %-40
B1 = (Q*y1')/N;
y2 = exp(1i*sin(stear2)*part2); %0
B2 = (Q*y2')/N;
y3 = exp(1i*sin(stear3)*part2); %20
B3 = (Q*y3')/N;
gn1 = 20*log10(abs(B1));
gn2 = 20*log10(abs(B2));
gn3 = 20*log10(abs(B3));
figure(1);
plot(rho_deg,gn1,'linewidth',2');
hold on;
plot(rho_deg,gn2,'y','linewidth',2'); 
hold on;
plot(rho_deg,gn3,'m','linewidth',2'); 
hold on;
ax = gca;
ax.FontSize = 30;
grid;
axis([-90 90 -60 15])
title('Beam Pattern for various Steering Angles');
xlabel('Angle [deg]');
ylabel('Beam intensity [dB]');
hL = legend('stearing angle = -20°','stearing angle = 0°','stearing angle = 20°');
hL.FontSize = 25;