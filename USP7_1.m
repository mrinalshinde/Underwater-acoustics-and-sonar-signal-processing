N = 15;  % number of elements
k.d = [pi,2*pi,4*pi];  % multiples of k and d
beta = -90:0.5:90;
b = zeros();
q = zeros();
B = zeros();
for i = 1:3
  for bet = 1:361
      b(bet) = 0;
    for j = 0:N-1
        q(bet) = exp(-j*k.d(i)*sind(beta(bet))*1i);
        b(bet) =b(bet)+q(bet);
    end
    b(bet) = b(bet)/N;  % complex beam pattern
    B(bet) = 20*log10(abs((b(bet)))); % beam pattern
  end
  figure
  plot(beta,B,'LineWidth',2);
  if i == 1
      title('Beam Pattern for element spacing, d = \lambda /2');
  else
      if i == 2
          title('Beam Pattern for element spacing, d = \lambda');
      else
      title('Beam Pattern for element spacing, d = 2\lambda');
      end
  end
  ylim([-30 0])
  xlim([-90 90])
  grid
  xlabel('Beta (deg)');
  ylabel('Level (dB)');
end