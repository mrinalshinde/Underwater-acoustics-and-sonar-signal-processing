A = 1; % Amplitude
D = 20; % Water depth [m]
r_S = 0; % Source location
z_S = 5; % Source location
c = 1480; % Sound speed
z_R = 0:0.1:D; % Receiver location
r_R = 0:1:500; % Receiver location
for i = 1:1:5
    f = 10.^i;
    k = 2.*pi.*f./c; % Wave number
    [z,r] = ndgrid(z_R,r_R);
    P = zeros(length(z_R),length(r_R),2);
    p = zeros(length(z_R),length(r_R),2);
    for m = 0:1:10 % more than 5 iterations
        C1 = 2.*D;
        C2 = z_S+z;
        C3 = z_S-z;
        l = m+1;
        C4 = C1.*m;
        C5 = C1.*l;
        L(:,:,1) = abs(r+1i.*(C4-C3));
        L(:,:,2) = abs(r+1i.*(C4+C2));
        L(:,:,3) = abs(r+1i.*(C5-C2));
        L(:,:,4) = abs(r+1i.*(C5+C3));
        P(:,:,2) = A*(-1)^m .* (exp(-1i.*k.*L(:,:,1))./L(:,:,1)...
                 -exp(-1i.*k.*L(:,:,2))./L(:,:,2)...
                 + exp(-1i.*k.*L(:,:,3))./L(:,:,3)...
                 -exp(-1i.*k.*L(:,:,4))./L(:,:,4)); 
        P = sum(P,3);
    end
   p(:,:,i) = P;
   CLIM = [-50 10];
   set(0,'DefaultAxesFontSize',30)
   figure(i)
   imagesc(r_R,z_R,10.*log10(abs(p(:,:,i))),CLIM); 
   colorbar('vert');
   xlabel('R [m]');
   ylabel('Z [m]');
   if i < 3
   title(strcat('Frequency = ',num2str(10.^i),' Hz '));
   else
       if i == 3
       title(strcat('Frequency = 1 kHz '));
       else
           if i == 4
                title(strcat('Frequency = 10 kHz '));
           else
                title(strcat('Frequency = 100 kHz '));
           end
       end
   end
end

