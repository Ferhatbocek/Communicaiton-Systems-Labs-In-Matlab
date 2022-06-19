clc;
Fs = 12000;
fm = 400;
fc = 3000;      Am = 1.5;        Ac1 = Am/0.4;       Ac2 = Am;      Ac3 = Am/1.8;      
t = 0:1/Fs:0.02;
mt = Am*sin(2*pi*fm*t);
ct1 = Ac1*cos(2*pi*fc*t);
ct2 = Ac2*cos(2*pi*fc*t);
ct3 = Ac3*cos(2*pi*fc*t);

st1 = (1 + (0.4.*mt)/Am).*ct1;
st2 = (1 + mt./Am).*ct2;
st3 = (1 + (1.8.*mt)/Am).*ct3;

figure(1)
subplot(4,1,1);
plot(t,mt);
xlabel("time (s)");
ylabel("m(t)");
grid on;
subplot(4,1,2);
plot(t,st1);
xlabel("time (s)");
ylabel("s_1(t)");
grid on;
subplot(4,1,3);
plot(t,st2);
xlabel("time (s)");
ylabel("s_2(t)");
grid on;
subplot(4,1,4);
plot(t,st3);
xlabel("time (s)");
ylabel("s_3(t)");
grid on;

% 3.2 e
f = linspace(-Fs/2,Fs/2,1024);
Mf = abs(fft(mt,1024));
Mf = Mf./1024;
Mf = fftshift(Mf);

Cf = abs(fft(ct2,1024));
Cf = Cf./1024;
Cf = fftshift(Cf);

Sf = abs(fft(st2,1024));
Sf = Sf./1024;
Sf = fftshift(Sf);

figure(2);
subplot(3,1,1);
plot(f,Mf);
grid on;
xlabel("frequency (Hz)");
ylabel("|M(f)|");

subplot(3,1,2);
plot(f,Cf);
grid on;
xlabel("frequency (Hz)");
ylabel("|C(f)|");

subplot(3,1,3);
plot(f,Sf);
grid on;
xlabel("frequency (Hz)");
ylabel("|S(f)|");

%part 3.3

stt = st2.*st2;
xt = stt*2;

[bl al] = butter(5,3000/(Fs/2),'low');
yt = filter(bl,al,xt);

yt = abs(yt);
rt = sqrt(yt);
m_tilda = rt - mean2(rt);

figure(3);
subplot(3,1,1);
plot(t,xt);
xlabel("time (s)");
ylabel("x(t)");
grid on;
subplot(3,1,2);
plot(t,yt);
xlabel("time (s)");
ylabel("y(t)");
grid on;
subplot(3,1,3);
plot(t,rt);
xlabel("time (s)");
ylabel("r(t)");
grid on;

figure(4);
plot(t,mt);
grid on;
hold on;
plot(t,m_tilda);
xlabel("time (s)");
legend("m(t)","m-tilda(t)");












