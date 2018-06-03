beta_d = -90:0.1:90; % angle between the vector R and the x-axis [deg]
beta_r= beta_d*pi/180; % angle between the vector R and the x-axis [rad]
N = 15; % number of hydrophones
lambda = 2;
k = 2*pi/lambda; % wave number
d = [lambda/2, lambda, 2*lambda]; % distance between hydrophones (element spacing)
alpha=1 ; % phase [deg]
Qn_head = ones(1,N); % Amplitude of the n-th point source or Hydrophone
alpha= ones(1,N); % Phase of the n-th point source or Hydrophone
scaling = [pi*2, pi, pi/2, pi/10]; % scaling factor for the parabolic shading
for x=1:3
  for n= -7:1:(N-1)/2
  alpha_parabolic(n+8,x)= scaling(x)*n^2/(((N-1)/2)^2); 
  end
end
subplot(121)
plot(-7:7,alpha_parabolic(:,1),-7:7,alpha_parabolic(:,2),...
    -7:7,alpha_parabolic(:,3),'linewidth',1.5);
grid
legend('360°','180°','90°');
xlabel('Hydophone (n)'),ylabel('\alpha'), Q_head= 0; % initialising variable
for n=1:N
term= Qn_head(n);
Q_head= Q_head + term;
end
for x=1:3
bp_sum= 0;
for n=1:N
sum(n,:)=Qn_head(n)*exp(j*(alpha_parabolic(n,x) - k*n*d(1)*sin(beta_r)));
bp_sum= bp_sum + sum(n,:);
end
bp(x,:)= 20*log10(abs(1/(Q_head)*bp_sum)); % beam pattern
subplot(122)
plot(beta_d,bp(1,:),beta_d,bp(2,:),beta_d,bp(3,:),'linewidth',1.5)
grid;
hold on;
legend('360°','180°','90°');
axis([-90 90 -30 0])
ylabel('Level [dB]')
xlabel('\beta [deg]')
end