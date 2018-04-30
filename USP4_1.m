ws = 5:5:30; % Wind speed in steps of 5kn
a(i) = [];
for n = 1:6
for i = 1:1000
a(i) = isotropic(i,ws(n),-999,-999,-999); % calling the nested function 
end
j = 1000:1000:10^6;
for k = 1:1000
l = k+1000;
a(l) = isotropic(j(k),ws(n),-999,-999,-999); % calling the nested function
end
 switch n
    case 1
        b=a;
    case 2
        c=a;
    case 3
        d=a; 
    case 4
        e=a; 
    case 5
        g=a;
    case 6
        h=a;
end
end
ii = 0.001:0.001:1;
kk = 1:1000;
f=[ii kk];
semilogx(f,b,f,c,f,d,f,e,f,g,f,h,'LineWidth',2)
ax = gca; % current axes
        ax.FontSize = 20;
hL = legend('wind speed = 5 kn','wind speed = 10 kn',...
    'wind speed = 15 kn','wind speed = 20 kn',...
    'wind speed = 25 kn','wind speed = 30 kn');
hL.FontSize = 20;
grid
title('Ambient Noise')
xlabel('Frequency [kHz]')
ylabel('Noise Level [dB]')

%nested function
function [nl_iso] = isotropic(freq,ws,rain, bio, self) 
nl_iso = 10*log10((10.^(.1*turb(freq))) + (10.^(.1*traffic(freq))) ...
    + (10.^(.1*seaState(freq ,ws))) + (10.^(.1*thermal(freq)))...
    +(10.^(.1*rain))+(10.^(.1*bio))+(10.^(.1*self)));
function [nl_turb] = turb(f)
    nl_turb = 30-30*log10(f./1000);
end
function [nl_traff] = traffic(f)
    nl_traff = 10*log10((3e+8)./(1+(1e+4*((f./1000).^4))));
end
function [nl_therm]=thermal(f)
    nl_therm=-15+20*log10(f./1000);
end
function [nl_sea] = seaState(f,vm)
    nl_sea = 40+10*log10((vm.^2)./(1+(f./1000).^(5/3)));
end
end
