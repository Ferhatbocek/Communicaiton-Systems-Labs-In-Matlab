clc;
clear;
clearvars;


%%  FM Modulation Part 

d=0.5;
fs=4000;
Ts=1/fs;
t=0:Ts:d;
N=length(t);
fv=linspace(-fs/2,fs/2,N);
fm=40;
fc=150;
ac=1;
am=3;
mt=3*cos(2*pi*fm*t);
ct=cos(2*pi*fc*t);

kf = [6 12 18];

st1=ac*cos(2*pi*fc*t+2*pi*kf(1)*cumsum(mt)*Ts);

st2=ac*cos(2*pi*fc*t+2*pi*kf(2)*cumsum(mt)*Ts);

st3=ac*cos(2*pi*fc*t+2*pi*kf(3)*cumsum(mt)*Ts);

figure(1);
subplot(411);
plot(t,mt);
title('m(t)');
xlabel('time(sec)');
ylabel('amplitude');

subplot(412);
plot(t,st1);
title('s1(t)');
xlabel('Time (sec)');
ylabel('amplitude');

subplot(413);
plot(t,st2);
title('s2(t)');
xlabel('Time (sec)');
ylabel('amplitude');

subplot(414);
plot(t,st3);
title('s3(t)');
xlabel('Time (sec)');
ylabel('magnitude');

SF1=abs(fftshift(fft(st1,N)))/N;

SF2=abs(fftshift(fft(st2,N)))/N;

SF3=abs(fftshift(fft(st3,N)))/N;

MF=abs(fftshift(fft(mt,N)))/N;

CF=abs(fftshift(fft(ct,N)))/N;


figure(2)  %% the message sigal and carrier signal in frequency domain
subplot(211);
plot(fv,MF);
title('|M(f)|'); xlabel('Frequency(Hz)'); ylabel('Magnitude');

subplot(212);
plot(fv,CF);
title('|C(f)|'); xlabel('Frequency(Hz)'); ylabel('Magnitude');


figure(3) %% three modulated signal and the message signal 
subplot(411);
plot(fv,MF);
title('|M(f)|'); xlabel('Frequency(Hz)'); ylabel('Magnitude');

subplot(412);
plot(fv,SF1);
title('|S_1(f)|'); xlabel('Frequency(Hz)'); ylabel('Magnitude');

subplot(413);
plot(fv,SF2);
title('|S_2(f)|'); xlabel('Frequency(Hz)'); ylabel('Magnitude');

subplot(414);
plot(fv,SF3);
title('|S_3(f)|'); xlabel('Frequency(Hz)'); ylabel('Magnitude');



%% FM Demodulation Part 2


sd1=am*fmdemod(st1,fc,fs,am*kf(1));

sd2=am*fmdemod(st2,fc,fs,am*kf(2));

sd3=am*fmdemod(st3,fc,fs,am*kf(3));


    

figure(4)

subplot(411);
plot(t,mt);
title('m(t)'); xlabel('Time (sec)'); ylabel(' Amplitude');
legend('m(t)');

subplot(412);
plot(t,sd1);
title('sd_1(t)'); xlabel('Time (sec)'); ylabel(' Amplitude');
legend('sd_1(t)');

subplot(413);
plot(t,sd2);
title('sd_2(t)'); xlabel('Time (sec)'); ylabel(' Amplitude');
legend('sd_2(t)');

subplot(414);
plot(t,sd3);
title('sd_3(t)'); xlabel('Time (sec)'); ylabel(' Amplitude');
legend('sd_3(t)');



