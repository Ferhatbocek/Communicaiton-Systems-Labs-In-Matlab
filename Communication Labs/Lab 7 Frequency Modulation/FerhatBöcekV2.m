clc;
close all;
%a
Fs = 4000;
Ts = 1/Fs;
d = 0.5;   fm = 40;   fc = 150;  Ac = 1;   Am = 3;
t = 0:Ts:d;
N = length(t);
kf = [6 12 18];
f = linspace(-Fs/2,Fs/2,N);
%b
mt = Am*cos(2*pi*fm*t);
ct = cos(2*pi*fc*t);
%c
s1 = Ac*cos(2*pi*fc*t + (2*pi*kf(1)*cumsum(mt)*Ts));
s2 = Ac*cos(2*pi*fc*t + (2*pi*kf(2)*cumsum(mt)*Ts));
s3 = Ac*cos(2*pi*fc*t + (2*pi*kf(3)*cumsum(mt)*Ts));

%d
figure(1);
subplot(4,1,1);
plot(t,mt);
grid on;
xlabel("time (s)");  ylabel("m(t)");
subplot(4,1,2);
plot(t,s1);
grid on;
xlabel("time (s)");  ylabel("s_1(t)");
subplot(4,1,3);
plot(t,s2);
grid on;
xlabel("time (s)");  ylabel("s_2(t)");
subplot(4,1,4);
plot(t,s3);
grid on;
xlabel("time (s)");  ylabel("s_3(t)");

Mf = (abs(fft(mt,N)))./N;
Mf = fftshift(Mf);

S1f = (abs(fft(s1,N)))./N;
S1f = fftshift(S1f);

S2f = (abs(fft(s1,N)))./N;
S2f = fftshift(S2f);

S3f = (abs(fft(s3,N)))./N;
S3f = fftshift(S3f);
%f
figure(2);
subplot(4,1,1);
plot(f,Mf);
grid on;
xlabel("frequency (Hz)");  ylabel("|M(f)|");
subplot(4,1,2);
plot(f,S1f);
grid on;
xlabel("frequency (Hz)");  ylabel("|S_1(f)|");
subplot(4,1,3);
plot(f,S2f);
grid on;
xlabel("frequency (Hz)");  ylabel("|S_2(f)|");
subplot(4,1,4);
plot(f,S3f);
grid on;
xlabel("frequency (Hz)");  ylabel("|S_3(f)|");

%7.2 a
sd1 = fmdemod(s1,fc,Fs,kf(1));
sd2 = fmdemod(s2,fc,Fs,kf(2));
sd3 = fmdemod(s3,fc,Fs,kf(3));

%b
figure(3);
subplot(3,1,1);
plot(t,mt);
hold on;
plot(t,sd1);
grid on;
xlabel("time (s)");
legend("m(t)","s1_d_e_m_o_d(t)");

subplot(3,1,2);
plot(t,mt);
hold on;
plot(t,sd2);
grid on;
xlabel("time (s)");
legend("m(t)","s2_d_e_m_o_d(t)");

subplot(3,1,3);
plot(t,mt);
hold on;
plot(t,sd3);
grid on;
xlabel("time (s)");
legend("m(t)","s3_d_e_m_o_d(t)");




