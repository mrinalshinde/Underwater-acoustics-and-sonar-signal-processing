vm=5;
for i=1:1000
iso(i)=isotropic(i,vm,-900,-900,-900); 
tur(i)=turb(i);
traff(i)=traffic(i); 
ther(i)=thermal(i); 
seast(i)=seastate(i,vm);
end
j=1000:1000:10^6;
for k=1:1000
l=k+1000;
iso(l)=isotropic(j(k),vm,-999,-999,-999); 
tur(l)=turb(j(k)); 
traff(l)=traffic(j(k));
ther(l)=thermal(j(k)); 
seast(l)=seastate(j(k),vm);
end
ii=.001:.001:1;
kk=1:1000;
f=[ii kk];
semilogx(f,iso,f,tur,'--',f,traff,'--',f,ther,'--',f,seast,'--','LineWidth',2)
ax = gca; % current axes
        ax.FontSize = 18;
        ax.YLim = [0 130];
legend('NL_i_s_o_t_r_o_p_i_c','NL_t_u_r_b','NL_t_r_a_f_f_i_c','NL_t_h_e_r_m','N L_s_s')
xlabel('Frequency [KHz]')
ylabel('Level [dB]')
title('contribution of different noises for Vm = 5 knots') 
grid on

% Turbulence noise:
function [nlturb]=turb(f)
          nlturb=30-30*log10(f./1000);
end
% Far ship (traffic) noise:
function [nltraff]=traffic(f)
nltraff=10*log10((3e+8)./(1+(1e+4*((f./1000).^4))));
end
% Thermal noise (molecular agitation):
function [nltherm]=thermal(f)
         nltherm=-15+20*log10(f./1000);
end
% Sea state noise:
function [sea]=seastate(f,vm)
sea=40+10*log10((vm.^2)./(1+(f./1000).^(5/3)));
end
% Isotropic noise level:
function [nliso]=isotropic(f,vm,rain,bio,self)
nliso=10*log10((10.^(.1*turb(f)))+(10.^(.1*traffic(f)))+(10.^(.1*seastate(f ,vm)))+(10.^(.1*thermal(f)))...
    +(10.^(.1*rain))+(10.^(.1*bio))+(10.^(.1*self)));
end