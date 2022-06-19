clc 
clear;
clearvars;
%% 4.1 DSB SB Modulation part a
fs = 10000;
fm = 80;
fc = 600;

d = 0.25;
Ts = 1/fs;
t = 0 : Ts: d;


N = length(t);
fvt = linspace(-fs/2,fs/2,N);

mt = 4*cos(2*pi*fm*t);
ct = cos(2*pi*fc*t);

st = mt.*ct;

%% 4.1 Plot m(t), c(t), s(t) signals in time domain part b
figure;
subplot(311);
plot(t,mt);
title('Message Signal');
xlabel('time');
ylabel('m(t)');

subplot(312);
plot(t,ct);
title('Carrier Signal');
xlabel('time');
ylabel('c(t)');

subplot(313);
plot(t,st);
title('Modulated Signal');
xlabel('time');
ylabel('s(t)');

%% 4.1 Plot m(t), s(t) signals in time domain part c
MF = abs(fftshift(fft(mt,N)))/N;
SF = abs(fftshift(fft(st,N)))/N;

figure;
subplot(211); 
plot(fvt,MF);
title("Magnitude of the frequency response of m(t)");
xlabel("Frequency (Hz)");
ylabel('M(f)'); 

subplot(212); 
plot(fvt,SF);
title("Magnitude of the frequency response of s(t)");
xlabel("Frequency (Hz)");
ylabel('S(f)');

%% 4.2 DSB SC Demodulation
%% vo(f)= 40 hertz
%% ac carrier amplitude 2V

ac=2; 
vt=ac*st.*ct;
vf=abs(fftshift(fft(vt,N)))/N;

figure;
plot(fvt,vf);
title("Magnitude of the frequency response v(t)");
xlabel("Frequency (Hz)");
ylabel('V(f)'); 

%% 4.2 DSB SC Demodulation Part d 
n=5;
Fc=60;
ass=Fc./(fs/2)
[b,a]=butter(n,Fc./(fs/2),'low Pass Filter');
vt0=filter(b,a,vt);
VF0=abs(fftshift(fft(vt0,N)))/N;

figure(4);
subplot(211); 
plot(t,vt0);
title('Demodulated Signal');
xlabel('time');
ylabel('s(t)'); 

subplot(212); 
plot(fvt,VF0);
title("Magnitude of the frequency response of v0(t)");
xlabel("Frequency (Hz)");
ylabel('V0(f)');




