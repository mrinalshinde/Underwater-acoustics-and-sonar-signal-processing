%file saved as UCP1_1.m
temperature = 5:5:30; % temperature varies in steps on 5 from 5 to 30
salinity = 10:5:35; % salinity varies in steps of 5 from 10 to 35
depth = 0:200:1000; % depth varies in steps of 200 from 0 to 1000
for i = 1:6
    u = temperature(i);
    for j = 1:6
        v = salinity(j);
        c = speedOfSound(v, u, depth); % calling the function
        subplot(3,2,i);
        hold on;
        plot(c,-depth,'LineWidth',1.5);
        title(['For temperature = ',num2str(temperature(i))])
        ax = gca; % current axes
        ax.FontSize = 8;
        ax.XLim = [1430 1570];

        % labelling of axes
        ylabel('Depth, z (m)')
        xlabel('Speed of sound, c (m/s)')
    end
end
% labelling of waveforms
hL = legend('S = 10', 'S = 15', 'S = 20', 'S = 25','S = 30', 'S = 35');
newPosition = [0.85 0.85 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);





