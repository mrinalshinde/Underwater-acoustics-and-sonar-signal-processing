tau = -5:0.05:5;
mu = -1.5:0.05:1.5;
T = max(tau);
B = max(mu);
sig = T/sqrt(2*pi);
k = B/T;
[tau,mu] = meshgrid(tau,mu);
amb_sig = abs(exp(1i*pi.*mu.*tau) .* (1 - abs(tau/T)) ...
    .* (sin(pi.*mu.*(T - abs(tau)))./(pi.*mu.*(T - abs(tau)))));
amb_sig = amb_sig.';
figure,contour(tau/5,mu,20*log10(amb_sig/max(max(amb_sig)))',-(0:5:25), ...
    'LineWidth',2)
colorbar
grid on
xlabel('Normalized time delay (\tau/\it T)','Interpreter','tex')
ylabel('Normalized Doppler frequency shift (\mu/\it B)','Interpreter','tex')
ax = gca; % current axes
ax.FontSize = 15;
title('\fontsize{25}Ambiguity Function of a Rectangular Pulse')
%LFM with rectangular envelope
tau = -5:0.05:5;
mu = -3:0.05:3;
[tau,mu] = meshgrid(tau,mu);
amb_sig = abs(exp(1i*pi.*mu.*tau) .* (1 - abs(tau/T)) ...
    .* (sin(pi.*(k.*tau + mu) .* (T - abs(tau)))./(pi.*(k.*tau + mu) ...
    .*(T - abs(tau)))));
amb_sig = amb_sig.';
figure,contour(tau/5,mu/2,20*log10(amb_sig/max(max(amb_sig)))',-(0:5:25), ...
    'LineWidth',2)
colorbar
grid on
xlabel('Normalized time delay (\tau/\it T)','Interpreter','tex')
ylabel('Normalized Doppler frequency shift (\mu/\it B)','Interpreter','tex')
ax = gca; % current axes
ax.FontSize = 15;
title('\fontsize{25}Ambiguity Function of a LFM with rectangular Envelope')
tau = -8:0.05:8;
mu = -3:0.05:3;
[tau,mu] = meshgrid(tau,mu);
amb_sig = abs(exp(1i*pi.*mu.*tau) .* exp((-(tau.^2)/(4*sig^2))  ...
    - (pi*sig^2.*(k.*tau + mu).^2)));
amb_sig = amb_sig.';
figure,contour(tau/5,mu/2,20*log10(amb_sig/max(max(amb_sig)))' ...
    ,-(0:5:25),'LineWidth',2)
colorbar
grid on
xlabel('Normalized time delay (\tau/\it T)','Interpreter','tex')
ylabel('Normalized Doppler frequency shift (\mu/\it B)','Interpreter','tex')
ax = gca; % current axes
ax.FontSize = 15;
title('\fontsize{25}Ambiguity Function of a LFM with Gaussian Envelope')
