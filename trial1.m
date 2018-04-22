clc;
clear all;
close all;
f=[50000, 100000, 200000 ,400000] ;
vw=[5, 10, 20, 40];
%color = {'y','b','g','r','m'};
theta= 0:0.01:pi/2;
theta_axis = theta .* (180/pi);
colors = ['r','g','b','m'];
model_name = [{'At f=50kHz'} {'At f=100kHz'} {'At f=200kHz'} {'At f=400kHz'}];
model_name2 = [{'At ws = 5 kn'} {'At ws = 10 kn'} {'At ws = 20 kn'} {'At ws = 40 kn'}];
legend_names = [{'ws = 5 kn'},{'ws = 10 kn'},{'ws = 20 kn'},{'ws = 40 kn'}];
legend_names2 = [{'f = 50 kHz'},{'f = 100 kHz'},{'f = 200 kHz'},{'f = 400 kHz'}];
for p=1:2
figure(p)
for l=1:4
subplot (2,2,l)
for q=1:4
if p==1
bet=4*((vw(q)+2)/(vw(q)+1))+(2.5*((f(l)+0.1)^(-1/3))-4).*cos(theta).^(1/8);
Ss = 10*log10(10^-5.05 * (1+vw(q))^2 * (f(l)+0.1)^(vw(q)/150).*(tan(theta)).^bet);
plot(theta_axis,Ss,'color',colors(q),'linewidth',2);
legend(legend_names,'location','southeastoutside');
hold on
title(model_name(l));
else
bet=4*((vw(l)+2)/(vw(l)+1))+(2.5*((f(q)+0.1)^(-1/3))-4).*cos(theta).^(1/8);
Ss=10*log10(((tan(theta)).^bet).*((1+vw(l))^2)*((f(q)+0.1)^(vw(l)/150))*(10^(-5.05)));
plot(theta_axis,Ss,'color',colors(q),'linewidth',2);
legend(legend_names2,'location','southeastoutside');
hold on
title(model_name2(l));
end
axis([0 2*40 -70 30])
set(gcf,'units','points','position',[10,10,1000,850]);
xlabel('Grazing angle [in degrees]');
ylabel('Surface reverberation [dB/m^2]');
end
end
end



