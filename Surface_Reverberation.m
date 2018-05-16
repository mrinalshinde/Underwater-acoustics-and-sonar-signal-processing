% Function file saved as 'Surface_Reverberation.m'
function [Ss] = Surface_Reverberation(f,Vw,g)
f = f./1000;
b = (4.*(Vw+2)./(Vw+1))+(2.5.*(f+0.1).^(-1./3)-4).* ...
    (abs(cos(g))).^(1/8);
Ss = 10.*log10(10.^(-5.05).*(1+Vw).^2.*(f+0.1).^(Vw./150).* ...
    (tan(g)).^(b));
end