N=15;  % number of element
k.d=[pi,2*pi,4*pi];  % the multiple of k and d
beta=-90:0.5:90;
for m=1:3
  for bet=1:361
      b(bet)=0;
    for n=0:N-1
        q(bet)=exp(-n*k.d(m)*sind(beta(bet))*j);
        b(bet)=b(bet)+q(bet);
    end
b(bet)=b(bet)/N;  %complex beam pattern
B(bet)=20*log10(abs((b(bet))));%beam pattern
  end
  figure
  plot(beta,B);
  ylim([-30 0])
  grid
  xlabel('beta(deg)');
  ylabel('Level (dB)');
end