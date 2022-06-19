clc 
clear;
clearvars;

%% 3.2 Conventional Amplitude Modulation 

d=0.08;
fs=12000;
Ts=1/fs;
t=0:Ts:d;
N=length(t);
fm=linspace(-fs/2,fs/2,N);

%b
am = 1.5;   
fm = 400;
fc = 3000;

ac1=am/0.4;
ac2=am/1;
ac3=am/1.8;

mt1= am*sin(2*pi*fm*t);
mt = sin(2*pi*fm*t);
ct = cos(2*pi*fc*t);
ct1= 1.5*cos(2*pi*fc*t);

%c
st_1 = ac1*(1 + 0.4*mt) .* ct;
st_2 = ac2*(1 + mt) .* ct;
st_3 = ac3*(1 + 1.8*mt) .* ct;

subplot(411);
plot(t,mt1);
title('Message Signal of mt');
xlabel('time');
ylabel('mt signal');

subplot(412)
plot(t,st_1);
title('Modulated Signal for u = 0.4');
xlabel('time');
ylabel('s_1(t)');

subplot(413);
plot(t,st_2);
title('Modulated Signal for u = 1');
xlabel('time');
ylabel('s_2(t)');

subplot(414);
plot(t,st_3);
title('Modulated Signal for u = 1.8');
xlabel('time');
ylabel('s_3(t)');

figure

% e)  Plot the magnitude responses of the signal m(t), c(t) for u = 1 

MT =abs(fftshift(fft(mt1,N)))/N;
CT =abs(fftshift(fft(ct1,N)))/N;
ST_1 =abs(fftshift(fft(st_1,N)))/N;

subplot(311); 
plot(t,MT);
title("Magnitude of the frequency response m(t)");
xlabel("Frequency (Hz)");
ylabel('M(f)'); 

subplot(312); 
plot(t,CT);
title("Magnitude of the frequency response c(t)");
xlabel("Frequency (Hz)");
ylabel('C(f)'); 

subplot(313); 
plot(t,ST_1);
title("Magnitude of the frequency response s(t) with u = 1 ");
xlabel("Frequency (Hz)");
ylabel('S(f)'); 
