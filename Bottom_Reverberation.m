function [Sb] = Bottom_Reverberation(f,bt,g)
f = f./1000;
% SEARAY Model "Bottom reverberation"
k = 1+125.*exp(-2.64.*(bt-1.75).^2-50./bt.*(cot(g)).^2); 
b = k.*(sin(g)+0.19).^(bt.*(cos(g)).^16);
Sb = 10.*log10(3.03.*b.*(f.^(3.2-0.8.*bt).* ...
    10.^(2.8.*bt-12)+10.^(-4.42)));
end