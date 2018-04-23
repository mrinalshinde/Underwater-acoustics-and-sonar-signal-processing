% Function saved as BottomBackScattering.m and is called from other MATLAB files
function [sB]= BottomBackScattering(frequency,bt,grazingAngle)
gamma = 1 + 125 ...
    .*exp(-2.64.*((bt-1.75).^2)-((50./bt).*(cotd(grazingAngle).^2)));
beta = gamma.*(sind(grazingAngle)+0.19).^(bt.*(cosd(grazingAngle).^16));
sB = 10.*log10(3.03 .* beta ...
    .* (frequency.^(3.2-0.8.*bt)) .* (10.^(2.8.*bt-12)) + 10^(-4.42));
end