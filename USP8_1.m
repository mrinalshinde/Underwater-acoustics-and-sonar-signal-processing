Fs = 200; %Sampling frequency
t = -1:1/Fs:1;
T = max(t); %pulse-width
B = 200; %bandwidth
k = B/T;
width = 0.5;
pulse = rectpuls(t,width);
figure('Color',[1 1 1]);
suptitle('\fontsize{25}Time and frequency domain of a Rectangular Pulse')
s1 = (1/sqrt(max(t))).*pulse;
subplot(1,2,1)
plot(t,s1,'LineWidth',2)
hold on
xlabel('Time [s]')
ylabel('Voltage [V]')
ax = gca; % current axes
ax.FontSize = 15;
a = title('Time Domain Representation','FontSize',20);
set(a,'Position',[0.00,-0.10],...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','center')
[f, fft_s1] = FFT(s1, Fs);
subplot(1,2,2)
plot(f, fft_s1,'LineWidth',2); 
xlabel('Frequency [Hz]')
ylabel('Log(Voltage) [V]') 
ax = gca; % current axes
ax.FontSize = 15;
a = title('Frequency Spectrum','FontSize',20);
set(a,'Position',[0.5,-9.5],...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','center')
figure('Color',[1 1 1]);
suptitle('\fontsize{25}Time and frequency domain of Linear Frequency Modulated signal with Rectangular Envelope')
s2 = (1/sqrt(max(t))).*pulse.*exp(1i*pi*k.*t.*t);
subplot(1,2,1)
plot(t,s2,'LineWidth',2)
xlabel('Time [s]')
ylabel('Voltage [V]')
ax = gca; % current axes
ax.FontSize = 15;
a = title('Time Domain Representation','FontSize',20);
set(a,'Position',[0.00,-1.20],...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','center')
[f, fft_s2] = FFT(s2, Fs);
subplot(1,2,2)
plot(f,fft_s2,'LineWidth',2);
xlabel('Frequency [Hz]')
ylabel('Log(Voltage) [V]') 
ax = gca; % current axes
ax.FontSize = 15;
a = title('Frequency Spectrum','FontSize',20);
set(a,'Position',[0.5,-1.8],...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','center')
figure('Color',[1 1 1]);
suptitle('\fontsize{25}Time and frequency domain of Linear Frequency Modulated signal with Gaussian Envelope')
sig = T/sqrt(2*pi);
s3 = (1/sqrt(sqrt(pi*sig*sig)))*exp(-((t.*t)/(2*sig*sig))  ...
    + (1i*pi*k.*t.*t));
subplot(1,2,1)
plot(t,s3,'LineWidth',2)
xlabel('Time [s]')
ylabel('Voltage [V]')
ax = gca; % current axes
ax.FontSize = 15;
a =title('Time Domain Representation','FontSize',20);
set(a,'Position',[0.05,-1.81],...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','center')
[f, fft_s3] = FFT(s3, Fs); 
subplot(1,2,2)
plot(f, fft_s3,'LineWidth',2); 
xlabel('Frequency [Hz]') 
ylabel('Log(Voltage) [V]') 
ax = gca; % current axes
ax.FontSize = 15;
a = title('Frequency Spectrum','FontSize',20);
set(a,'Position',[0.5,-1.81],...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','center')
 
function [ f, fft_sig_val ] = FFT( sig, Fs )
% Discrete Fourier Transform 
L = length(sig);
N = 512; fft_sig=fft(sig,N);
f = (-N/2:(N/2) - 1)*(Fs/N);
fft_sig_val = fftshift(fft_sig); 
fft_sig_val = abs(fft_sig_val);
end