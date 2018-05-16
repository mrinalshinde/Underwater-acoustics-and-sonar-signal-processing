% Function file saved as 'Atten_Schulkin_Marsh.m'
function [A] = Atten_Schulkin_Marsh(f,S,T,Zmax)
A = 2.34e-6;
B = 3.38e-6;
f = f./1000;
ft = 21.9.*10.^(6-(1520./(T+273)));
P = 1.01.*(1+Zmax.*0.1);
A = 8.686e3.*((S.*A.*ft.*f.^2)./(ft^2+f.^2)+(B.*f.^2)./(ft)) ...
    *(1-6.54e-4.*P);
end
