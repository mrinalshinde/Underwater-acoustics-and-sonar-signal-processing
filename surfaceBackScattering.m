% Function saved as surfaceBackScattering.m and is called from other MATLAB files
function [sS]= surfaceBackScattering(f,vW,grazingAngle)
beta = 4*((vW+2)/(vW+1)) + (2.5*((f+0.1)^(-1/3))-4) ...
    .* cosd(grazingAngle) .^ (1/8);
sS = 10*log10(((tand(grazingAngle)).^beta) ...
    .*((1+vW)^2)*((f+0.1)^(vW/150))*(10^(-5.05)));
end