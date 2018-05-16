% Function file saved as 'Noise_Level.m'
function NL = Noise_Level(f,Vw)
f = f./1000;
NLTraffic = 10.*log10(3e8./(1+1e4.*f.^4)); % Shipping noise (traffic)
NLTurb = 30-30.*log10(f);  % Turbuleance noise
NLVessel = -999; % Self noise of sonar platform (vessel)
NLBio = -999; % Biological noise (fishes, scrimps, etc.)
NLSS = 40+10.*log10(Vw.^2./(1+f.^(5/3))); % Sea state noise
NLThermal = -15+20.*log10(f); % Thermal noise
% Total isotropic noise level
NL = 10.*log10(10.^(0.1.*NLTraffic)+10.^(0.1.*NLTurb)+10.^ ...
    (0.1.*NLVessel)+10.^(0.1.*NLBio)+10.^(0.1.*NLSS)+10.^ ...
    (0.1.* NLThermal));
end
