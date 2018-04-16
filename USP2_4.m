%file saved as USP2_3.m
frequency = 0.1:166667:1000000;
z_max = 0.5;
temperature = 5:5:30;
salinity = 35; 
A=[];
for i=1:6
    u=temperature(i);
    C = 1412 + 3.21*temperature(i) + 1.19*salinity+0.0167*z_max;
    pH = 8; 
    A1 = 8.686 ./ C *10^(0.78*pH-5);
    p1 = 1; 
    f1 = 2.8*sqrt(salinity./35).*10.^(4-1245./(temperature(i)+273));
    boric_Acid = (A1.*p1.*f1.*frequency.^2)./(f1.^2+frequency.^2);
    A2 = 21.44*(salinity/C)*(1+0.025*temperature(i));
    p2 = 1 - 1.37e-4*z_max + 6.2e-9*z_max^2;
    f2 = 8.17*10^(8-(1990/(temperature(i)+273)))/(1+0.0018*(salinity-35));
    Mag_sulf = (A2*p2*f2*frequency.^2)./(f2^2+frequency.^2);
    if temperature(i)<=20
    A3 = (4.937e-4) - (2.59e-5*temperature(i)) ...
        + (9.11e-7*(temperature(i)^2)) - (1.5e-8*(temperature(i)^3));
    else
    A3 = (3.964e-4) - (1.146e-5*temperature(i)) ...
        + (1.45e-7*(temperature(i)^2)) - 6.5e-10*(temperature(i)^3);
    end
p3 = 1 - (3.83e-5*z_max) + (4.9e-10*z_max^2); 
pure_Water = A3*p3*frequency.^2;
A = [A ;(boric_Acid + Mag_sulf + pure_Water)];
end
figure (); 
plot(temperature,A(1,:),temperature,A(2,:),temperature,A(3,:), ...
    temperature,A(4,:),temperature,A(5,:),temperature,A(6,:),'linewidth',2)
ax = gca; %current axis
ax.XLim = [4 15];
set(gca, 'YScale', 'log')
xlabel('Temperature ( ^{\circ}C)'); 
ylabel('Attenuation coefficient (dB/Km)'); 
hL = legend('At T=5','At T=10','At T=15','At T=20','At T=25','At T=30');
newPosition = [0.85 0.85 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);

