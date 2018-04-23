frequency = logspace(1,7) * 0.001;
Sp = [-50 -70 -90];
for i = 1:3
sV(i,:)= volumeBackScattering(Sp(i),frequency);
end
semilogx(frequency,sV,'LineWidth',2)
ax = gca;
ax.FontSize = 16;
title('Volume backscattering coefficient versus frequency')
grid on
xlabel('Frequency [kHz]')
ylabel('Volume Reverberation [dB/m^2]')
hL = legend('High particle density (-50 dB)', ...
    'Moderate particle density (-70 dB)','Low particle density (-90 dB)')
hL.FontSize = 15;
