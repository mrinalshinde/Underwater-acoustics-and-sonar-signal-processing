beta_deg = -90:0.1:90; % angle between the vector R and the x-axis [deg]
beta_rad = beta_deg*pi/180; % angle between the vector R and the x-axis [rad]
N = 15; % number of hydrophones
lambda = 2; % wavelength
k = 2*pi/lambda; % wave number
d= [lambda/2, lambda, 2*lambda]; % distance between hydrophones (element spacing)
Qn_head = ones(1,N); % Amplitude of the n-th point source or Hydrophone
alpha = ones(1,N); % Phase of the n-th point source or Hydrophone
scaling = [pi*2, pi, pi/2, pi/10]; % scaling factor for the parabolic shading
alpha_parabolic = zeros();
for x=1:3
 for n= -7:1:(N-1)/2
  alpha_parabolic(n+8,x) = scaling(x)*n^2/(((N-1)/2)^2);
 end
end
figure
plot(-7:7,alpha_parabolic(:,1),-7:7,alpha_parabolic(:,2),...
    -7:7,alpha_parabolic(:,3),'linewidth',2);
title('Parabolic Phase Shading ')
grid
legend('360°','180°','90°');
xlabel('Hydophone (n)')
ylabel('Phase, \alpha')
Q_head = 0; % initialising variable 
for n = 1:N
 term = Qn_head(n);
 Q_head = Q_head + term;
end
for x = 1:3
 bp_sum = 0;
 for n = 1:N
  sum(n,:) = Qn_head(n)*exp(1i*(alpha_parabolic(n,x) ...
      - k*n*d(1)*sin(beta_rad)));
  bp_sum = bp_sum + sum(n,:);
 end
 bp(x,:) = 20*log10(abs(1/(Q_head)*bp_sum)); % beam pattern
end
figure
plot(beta_deg,bp(1,:),beta_deg,bp(2,:),beta_deg,bp(3,:),'linewidth',2)
title('Beam Pattern for various phase shifts ')
grid; 
hold on;
legend('360°','180°','90°'); 
axis([-90 90 -30 0])
ylabel('Level [dB]')
xlabel('\beta [deg]')