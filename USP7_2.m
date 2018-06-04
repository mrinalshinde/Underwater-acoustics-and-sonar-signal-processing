deg2rad = pi/180; % conversion to rad
beta_deg = -90:0.1:90; % angle between the vector R and the x-axis [deg] 
beta_rad = beta_deg*deg2rad; % angle between the vector R and the x-axis [rad] 
N = 15; % number of hydrophones
lambda = 2; % Wavelength [m]
k = 2*pi/lambda; % wave number
d = [lambda/2, lambda, 2*lambda]; % distance between hydrophones (element spacing)
Qn_head = ones(1,N); % Amplitude of the n-th point source or Hydrophone 
alpha = ones(1,N); % Phase of the n-th point source or Hydrophone
w = chebwin(15,30);
Q_head = 0; % initialising variable
for n = 1:N
term = Qn_head(n);
Q_head = Q_head + term;
end
for x = 1:3
 bp_sum = 0;
  for n = 1:N
  sum(n,:) = Qn_head(n)*w(n)*exp(1i*(alpha(n) - k*n*d(x)*sin(beta_rad)));
  bp_sum = bp_sum + sum(n,:);
  end
 bp = 20*log10(abs(1/(Q_head)*bp_sum)); % beam pattern 
 figure
 %subplot(3,1,x)
 plot(beta_deg,bp,'linewidth',2)
 grid;
 axis([-90 90 -50 0])
 ylabel('Level [dB]')
 xlabel('\beta [deg]')
 switch num2str(d(x))
case '1'
title(' Beam Pattern for element spacing, d= \lambda/2')
case '2'
title('Beam Pattern for element spacing, d= \lambda ')
case '4'
title('Beam Pattern for element spacing, d= 2\lambda')
end
end

