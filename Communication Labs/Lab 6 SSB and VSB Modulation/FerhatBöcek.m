clear all;
clc;

d=0.04;
Fs=19000;
fm=300;
fc=6000;

t=0:1/Fs:d;
m=5*cos(2*pi*fm.*t);
c=cos(2*pi*fc.*t);



sdsb=m.*c;
SDSB=fftshift(fft(sdsb,2048));
%% Filtering  d) obtain and plot the filters freq response 
Wn=2*fc/Fs;
n=23;
[bn,an]=butter(n,Wn,'low');
[hn,wn]=freqz(bn,an,Fs/2);

s=filter(bn,an,sdsb);
SVSB=fftshift(fft(s,2048));

fl=wn/2*pi;
f=linspace(-Fs/2,Fs/2,2048);

figure(1);
subplot(2,1,1);
plot(t,m); 
xlabel('time'); 
ylabel('amplitude'); 
title('m(t)');
subplot(2,1,2);
plot(t,c); 
xlabel('time'); 
ylabel('amplitude'); 
title('c(t)');

figure(2);
plot(Fs*fl,abs(hn)); 
xlabel('f'); 
ylabel('amplitude'); 
title('H(f)');

figure(3);
subplot(2,1,1)
plot(f,abs(SDSB)); 
xlabel('f'); 
ylabel('amplitude'); 
title('Sdsb');
subplot(2,1,2)
plot(f,abs(SVSB)); 
xlabel('f'); 
ylabel('amplitude'); 
title('Svsb(f)');



%% SSB Demodulation 


c1=4*c;
v=c1.*s;


fc1=2*fm;
Wn1=2*fc1/Fs;
n=4;
[b1,a1]=butter(n,Wn1,'low');
[h1,w1]=freqz(b1,a1,Fs/2);

y=filter(b1,a1,v);
M=fftshift(fft(m,2048));
Y=fftshift(fft(y,2048));


figure(4);
plot(t,m); hold on;
plot(t,y); 
xlabel('time'); 
ylabel('amplitude'); 
legend('m(t)','m2(t)'); 
title('message signal/demodulated signal');










