% Function saved as speedOfSound.m and is called from other MATLAB files
function c = speedOfSound(S, T, Z)
c = 1449.2 + 4.6*T - 0.055*T.^2 + 0.00029*T.^3 ...
               + 1.34*S - 46.9 - 0.01*T.*S + 0.35*T + 0.016*Z;
end
