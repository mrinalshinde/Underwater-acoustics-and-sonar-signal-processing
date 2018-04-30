freq = 0.001:0.01:1000; % frequency range
ws = 5; % wind speed set to 5kn
rain = -999; % Rainfall NL
bio = -999; % Biological NL
vessel = -999; % Self NL
traffic = 10.*log10((3.*10.^8)./(1+(10.^4.*freq.^4))); % Traffic NL
semilogx(freq,traffic,'--','linewidth',2)
hold on
turb = 30 - 30.*log10(freq) ;% Turbulence NL
semilogx(freq,turb,'--','linewidth',2)
hold on
seaState = 40 +10.*log10((ws.^2)./(1+freq.^(5/3))); % Sea state NL
semilogx(freq,seaState,'--','linewidth',2)
hold on
N_therm = -15 +20.*log10(freq); % Thermal NL
semilogx(freq,N_therm,'--','linewidth',2)
hold on
isotropic = 10.*log10((10.^(0.1.*turb)) + (10.^(0.1.*traffic))...
    + (10.^(0.1.*seaState)) + (10.^(0.1.*N_therm)) + (10.^(0.1.*rain))...
    + (10.^(0.1.*bio)) + (10.^(0.1.*vessel))); % Isotropic NL
semilogx(freq,isotropic, 'linewidth',2)
ax = gca; % current axes
        ax.FontSize = 20;
        ax.YLim = [0 130];
xlabel('Frequency [KHz]')
ylabel('Noise Level [dB]')
title('Contribution of different noises for Vm = 5 kn') 
grid on
hL =legend('NL_t_r_a_f_f_i_c','NL_t_u_r_b','N L_s_s', ...
    'NL_t_h_e_r_m','NL_i_s_o_t_r_o_p_i_c');
hL.FontSize = 20;

