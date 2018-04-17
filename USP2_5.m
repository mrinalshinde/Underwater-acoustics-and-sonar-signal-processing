% file saved as UCP1_5.m
temperature = 5:5:30; 
salinity = 10:5:35;
frequency = 0.1:10000;
depth_max = 0.5; 
p1 = 1; 
p2 = 1 - (1.37 * 10^-4 * depth_max) + (6.2 * 10^-9 * depth_max^2);
p3 = 1 - (3.83 * 10^-5 * depth_max) + (4.9 * 10^-10 * depth_max^2);
for i = 1:6
    u = salinity(i);
    for j = 1:6
        v = temperature(j);
        c = 1412 + 3.21*v + 1.19*u + 0.0167*depth_max;
        f1 = 2.8 * sqrt((u/35)) * 10^(4 - (1245/(v+273)));
        f2 = (8.17 * 10^(8-1990/(v+273))) / (1 + 0.0018*(u-35));
        a1 = ((8.686/c) * 10^(0.78*ph - 5));
        a2 = 21.44*(u/c)*(1 + 0.025*v);
if v <= 20
a3 = (4.937 * 10^-4) - (2.59 * 10^-5)*v ...
    + (9.11 * 10^-7)*(v^2) - (1.5 *10^-8)*(v^3);
else
a3 = (3.964 * 10^-4) - (1.146 * 10^-5)*v ...
    + (1.45 * 10^-7)*(v^2) - (6.5.*10^-10)*(v^3);
end
boric_Acid = ((a1.*p1.*f1.*frequency.^2)./((f1.^2)+(frequency.^2)));
magnesium_Sulphate = ((a2.*p2.*f2.*frequency.^2)./((f2.^2)+(frequency.^2)));
pure_Water = (a3.*p3.*frequency.^2);
all_Contributions = boric_Acid + magnesium_Sulphate + pure_Water;

        subplot(3,2,i);
        hold on;
        plot(frequency,all_Contributions,'LineWidth',1);
        title(['For salinity = ',num2str(salinity(i))])
        ax = gca; % current axes
        ax.FontSize = 8;
        set(gca, 'YScale', 'log', 'XScale','log')
        %ax.XLim = [1430 1570];
        ylabel('Attenuation coefficient [dB/km]')
        xlabel('Frequency[KHz]')
    end
end
hL = legend('T = 5', 'T = 10', 'T = 15', 'T = 20','T = 25', 'T = 30');
newPosition = [0.85 0.85 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);





