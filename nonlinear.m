temperature = 5:5:30; % temperature varies in steps on 5 from 5 to 30
salinity = 10:5:35; % salinity varies in steps of 5 from 10 to 35
depth = 0:1000; % depth varies in steps of 1 from 0 to 1000
u = 4; % salinity
v = 10; % temperature
expo_temp = 20*exp(-depth.^.1);
line(expo_temp,-depth,'color','g','LineWidth',1.5);
ax1 = gca; %current axis
ax1.XColor = 'r';
ax1.YColor = 'r';
ax1.XLim = [0 35];
ylabel('Depth, z (m)')
xlabel('Temperature, T (degree celcius)')
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
ax2.XLim = [1450 1468];
ax2.YLim = [-1000 0];
ylabel('Depth, z (m)')
xlabel('Sound velocity, c (m/s)')
c = speedOfSound(u, v, depth); % calling the function
line(c,-depth,'Parent',ax2,'Color','k','LineWidth',1.5)
c = speedOfSound(26, expo_temp, depth); % calling the function
line(c,-depth,'Parent',ax2,'Color','b','LineWidth',1.5)











