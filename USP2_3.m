%file saved as USP2_3.m
frequency=0.1:166667:1000000; 
z_max = 0.5;
temperature = 15;
salinity = 10:5:35;
A=[]; 
for i = 1:6
    u = salinity(i);
c = 1412 + 3.21*temperature + 1.19*salinity(i) + 0.0167*z_max;
ph=8;
A1 = 8.686 ./ c *10^(0.78*ph-5); 
p1 = 1; 
f1 = 2.8*sqrt(salinity(i)./35).*10.^(4-1245./(temperature+273)); 
boric_Acid = (A1.*p1.*f1.*frequency.^2)./(f1.^2+frequency.^2);
A2 = 21.44*(salinity(i)/c)*(1+0.025*temperature);
p2 = 1-1.37e-4*z_max+6.2e-9*z_max^2; 
f2 = 8.17*10^(8-(1990/(temperature+273)))/(1+0.0018*(salinity(i)-35));
Magnesium_Sulphate = (A2*p2*f2*frequency.^2)./(f2^2+frequency.^2);
if temperature <= 20
A3 = (4.937e-4) - (2.59e-5*temperature)...
    + (9.11e-7*(temperature^2)) - (1.5e-8*(temperature^3));
else
A3 = (3.964e-4) - (1.146e-5*temperature) ...
    + (1.45e-7*(temperature^2)) - 6.5e-10*(temperature^3);
end
p3 = 1-(3.83e-5*z_max)+(4.9e-10*z_max^2);
pure_Water = A3*p3*frequency.^2;
A = [A;(boric_Acid + Magnesium_Sulphate + pure_Water)];
end
figure (); 
plot(salinity,A(1,:),salinity,A(2,:),salinity,A(3,:), ...
    salinity,A(4,:),salinity,A(5,:),salinity,A(6,:),'linewidth',2)
ax = gca; %current axis
ax.XLim = [9.5 15.5];
set(gca, 'YScale', 'log')
xlabel('Salinity [ppt]');
ylabel('Attenuation coefficient (dB/Km)');
hL = legend('At S=10','At S=15','At S=20','At S=25','At S=30','At S=35');
newPosition = [0.85 0.85 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);
magnify;

