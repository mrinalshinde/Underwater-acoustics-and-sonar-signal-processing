frequency = 0.1:10000;
depth = 50;
temperature = 15; 
salinity = 25; 
A = 2.34*10^-6;
B = 3.38*10^-6;
relaxation_frequency = 21.9 * 10^(6-1520/(temperature+273));
pressure = 1.01 * (1 + depth * 0.1);
P1 = 1; 
P2 = 1 - (1.37*10^-4)*depth + (6.2 * 10^-9 * depth^2);
P3 = 1 - (3.83*10^-5)*depth + (4.9 * 10^-10 * depth^2);
c = 1412 + 3.21*temperature + 1.19*salinity + 0.0167*depth;
f1 = 2.8 * sqrt((salinity/35)) * 10^(4 - (1245/(temperature+273)));
f2 = (8.17 * 10^(8-1990/(temperature+273))) / (1 + 0.0018*(salinity-35));
ph = 8;
A1 = ((8.686/c) * 10^(0.78*ph - 5));
A2 = 21.44*(salinity/c)*(1 + 0.025*temperature);
if temperature<=20
A3 = (4.937 * 10^-4) - (2.59 * 10^-5)*temperature ...
    + (9.11 * 10^-7)*(temperature^2) - (1.5 *10^-8)*(temperature^3);
else
A3 = (3.964 * 10^-4) - (1.146 * 10^-5)*temperature ...
    + (1.45 * 10^-7)*(temperature^2) - (6.5.*10^-10)*(temperature^3);
end

thorp = ((0.11.*frequency.^2)./(1+frequency.^2)) ...
    + ((44.*frequency.^2)./(4100+frequency.^2));

shulkin_marsh = 8.686*10^3*(((salinity.*A.*relaxation_frequency.*frequency.^2) ...
    ./(relaxation_frequency.^2 + frequency.^2)) ...
    + (B.*frequency.^2)./relaxation_frequency) ...
    .*(1 - 6.54*10.^-4.*pressure);

francois_garrison = ((A1.*P1.*f1.*frequency.^2)./(f1.^2 + frequency.^2))...
    + ((A2.*P2.*f2.*frequency.^2)./(f2.^2 + frequency.*2)) ...
    + (A3.*P3.*frequency.^2);

figure(); 
loglog(frequency,Thorp,'b','linewidth',1.5), hold on; 
loglog(frequency,shulkin_marsh,'color',[0 0.5 0],'linewidth',1.5), hold on; 
loglog(frequency,francois_garrison,'r','linewidth',1.5);
grid on;
xlabel('frequency (KHz)'); 
ylabel('Attenuation (dB/Km)'); legend('Thorp','Schulkin-Marsh','Francois & Garrison');
