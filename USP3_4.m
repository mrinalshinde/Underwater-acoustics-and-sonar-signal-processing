frequency = [50 100 200 400];
bt = [1 2 3 4];
grazingAngle = 0:90; 
for i = 1:4
    subplot(2,2,i)
    sB = [];
    for j = 1:4
    sB = [sB;BottomBackScattering(frequency(j),bt(i),grazingAngle)]; % calling the function
    end
plot(grazingAngle,sB,'LineWidth',2)
axis([0 90 -45 5])
grid on
xlabel('Grazing Angle [deg]')
ylabel('Bottom Reverberation [dB/m^2]') 
ax = gca;
ax.FontSize = 16;
title(sprintf('bt = %d' ,bt(i)))
end
hL = legend('Frequency = 50 kHz','Frequency = 100 kHz','Frequency = 200 kHz','Frequency = 400 kHz');
newPosition = [0.85 0.85 0.15 0.18];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
hL.FontSize = 15;

