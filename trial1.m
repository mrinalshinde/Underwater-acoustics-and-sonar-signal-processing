f = 0.001:0.01:1000; % frequency range
v = 5:5:30; % Wind speed in steps of 5kn
Isotropic_NL = []; % AMbient noise level
for i = 1:6
vm = v(i);
N_turb = 30 - 30.*log10(f); % Turbulence Noise level
N_traffic = 10.*log10((3.*10.^8)./(1+(10.^4.*f.^4))); % traffic NL
N_state = 40 +10.*log10((vm.^2)./(1+f.^(5/3))); %Sea State NL
N_therm = -15 +20.*log10(f); % Thermal NL
N_rain = -999; N_bio = -999; N_vessel = -999;
Isotropic_NL = [Isotropic_NL;10.*log10((10.^(0.1.*N_turb)) + ...
    (10.^(0.1.*N_traffic)) + (10.^(0.1.*N_state)) + (10.^(0.1.*N_therm)) ...
    + (10.^(0.1.*N_rain)) + (10.^(0.1.*N_bio)) + (10.^(0.1.*N_vessel)))];
end
semilogx(f,Isotropic_NL, 'linewidth',1.5)
grid on
axis([10^-3 10^3 20 140])
xlabel('Frequency in KHz')
ylabel('Levels in dB')
legend('Wind speed = 5kn','Wind speed = 10kn','Wind speed = 15kn', ...
    'Wind speed = 20kn','Wind speed = 25kn','Wind speed = 30kn')
title('Ambient Noise')