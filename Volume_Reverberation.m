% Function file saved as 'Volume_Reverberation.m'
function [Sv] = Volume_Reverberation(f,Pd)
f = f./1000; 
if Pd == '1'
    SP = -50;
else
    if Pd == '0.5'
        SP = -70;
else
SP = -90;
   end
end
Sv = SP+7.*log10(f);
end