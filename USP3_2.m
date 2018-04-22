frequency = 50; 
grazingAngle = 0:0.01:pi/2;
n = length(grazingAngle);
theta = linspace(0,90,n);
for i = 0:1:3
    vW = 5*(2^i);
    subplot(2,2,i+1);
    for j=0:1:3
frequency = 50*(2^j);
beta = 4*((vW+2)/(vW+1)) + (2.5*((frequency+0.1)^(-1/3))-4) ...
    .*cos(grazingAngle).^(1/8);
sS = 10*log10(((tan(grazingAngle)).^beta) ...
    .*((1+vW)^2)*((frequency+0.1)^(vW/150))*(10^(-5.05)));
grid on; 
axis([0 100 -70 10])
plot(theta,sS,'LineWidth',2),
title(['Wind speed = ',num2str(vW),'kn']),
xlabel('Grazing angle [deg]'),
ylabel('Surface reverberation [dB/m^2]') 
ax = gca;
ax.FontSize = 12;
ax.YLim = [-70 10];
%ax.Xlim = [0 90];
hold on
    end
end
hL = legend('f = 50 kHz','f = 100 kHz','f = 200 kHz','f = 400 kHz');
newPosition = [0.85 0.85 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
hL.FontSize = 13;



