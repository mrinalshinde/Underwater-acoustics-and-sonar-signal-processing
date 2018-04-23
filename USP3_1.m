frequency = [50 100 200 400];
vW = [5 10 20 40];
grazingAngle = 0:90;
for i = 1:4
    subplot(2,2,i)
    sS = [];
    for j = 1:4
    sS = [sS;surfaceBackScattering(frequency(i),vW(j),grazingAngle)]; % calling the function
    end
plot(grazingAngle,sS,'LineWidth',2)
axis([0 90 -60 0])
grid on
xlabel('Grazing Angle [deg]')
ylabel('Surface Reverberation [dB/m^2]') 
ax = gca;
ax.FontSize = 16;
title(sprintf('Frequency = %d kHz' ,frequency(i)))
end
hL = legend('WS = 5 kn','WS = 10 kn','WS = 20 kn','WS = 40 kn');
newPosition = [0.85 0.85 0.15 0.18];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
hL.FontSize = 15;

