clc;
fs = 1000;
T = 1/fs;
t = linspace(-0.25,0.25,500);
t 
fc1=100;
fc2=200;
fc3=300;

figure
sig = sin(2*pi*fc1*t) + 2*sin(2*pi*fc2*t) + 0.5*sin(2*pi*fc3*t);
plot(sig)
hold on;



%low-pass
[bl al] = butter(10,fc1/(fs/2),'low');
low = filtfilt(bl,al,sig);
low_freq = fft(low,500);
low_freq = abs(fftshift(low_freq));
%high-pass
[bh ah] = butter(10,fc3/(fs/2),'high');
high = filtfilt(bh,ah,sig);
high_freq = fft(high,500);
high_freq = abs(fftshift(high_freq));
%bandpass
[bp ap] = butter(16,[(fc2-50)/(fs/2) (fc2+50)/(fs/2) ],'bandpass');
pass = filtfilt(bp,ap,sig);
pass_freq = fft(pass,500);
pass_freq = abs(fftshift(pass_freq));
freqz(bp,ap)


figure
subplot(3,2,1);
plot(t,low);
subplot(3,2,2);
plot(low_freq);
subplot(3,2,3);
plot(t,high);
subplot(3,2,4);
plot(high_freq);
subplot(3,2,5);
plot(pass);
subplot(3,2,6);
plot(pass_freq);
figure



