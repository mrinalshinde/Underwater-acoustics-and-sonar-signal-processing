freq = 0.001:0.01:1000; % frequency range
ws = 5:5:30; % Wind speed in steps of 5kn
a(i) = []; % Ambient noise level
for i = 1:6
vm = ws(i);
a(i) = isotropic(freq,ws(n),-999,-999,-999); % calling the nested function 
end
semilogx(freq,isotropic, 'linewidth',1.5)
grid on
axis([10^-3 10^3 20 140])
xlabel('Frequency in KHz')
ylabel('Levels in dB')
legend('Wind speed = 5kn','Wind speed = 10kn','Wind speed = 15kn', ...
    'Wind speed = 20kn','Wind speed = 25kn','Wind speed = 30kn')
title('Ambient Noise')

%nested function
function [nliso]=isotropic(freq,vm,rain,bio,self) 
nliso=10*log10((10.^(.1*turb(freq)))+(10.^(.1*traffic(freq)))+ ...
    (10.^(.1*seastate(freq ,vm)))+(10.^(.1*thermal(freq)))...
    +(10.^(.1*rain))+(10.^(.1*bio))+(10.^(.1*self)));
function [nlturb]=turb(f)
          nlturb=30-30*log10(f./1000);
end
function [nltraff]=traffic(f)
nltraff=10*log10((3e+8)./(1+(1e+4*((f./1000).^4))));
end
function [nltherm]=thermal(f)
         nltherm=-15+20*log10(f./1000);
end
function [sea]=seastate(f,vm)
sea=40+10*log10((vm.^2)./(1+(f./1000).^(5/3)));
end
end