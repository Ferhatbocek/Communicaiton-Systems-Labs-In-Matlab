clc;
Fs =10000;
fc = 600;
fm = 80;
Ac = 1;  Am = 4 ;
t = 0:1/Fs:0.25;
n = 0:1:length(t);

%4.1 a,b,c

mt = Am*cos(2*pi*fm*t);
ct = Ac*cos(2*pi*fc*t);
st = mt.*ct;
figure(1)
subplot(3,1,1);
plot(t,mt);
xlabel("time (s)");
ylabel("m(t)");
subplot(3,1,2);
plot(t,ct);
xlabel("time (s)");
ylabel("c(t)");
subplot(3,1,3);
plot(t,st);
xlabel("time (s)");
ylabel("s(t)");


f = linspace(-Fs/2,Fs/2,length(st));
Mf = abs(fft(mt))./(length(mt));
Mf = fftshift(Mf);

Cf = abs(fft(ct))./(length(ct));
Cf = fftshift(Cf);


Sf = abs(fft(st))./(length(st));
Sf = fftshift(Sf);

figure(2)
subplot(2,1,1);
plot(f,Mf);
xlabel("frequency (Hz)");
ylabel("|M(f)|");
axis([-1000 1000 0 2.1]);
grid on;
subplot(2,1,2);
plot(f,Sf);
xlabel("frequency (Hz)");
ylabel("|S(f)|");
grid on;
axis([-1000 1000 0 2.1]);

%4.2 a,b,c,d,e

vt = st.*cos(2*pi*(fc+40)*t);
vt = vt.*2;

Vf = abs(fft(vt))./(length(vt));
Vf = fftshift(Vf);

figure(3)
plot(f,Vf); 
xlabel("frequency (Hz)");
ylabel("|V(f)|");
grid on;


[bl,al] = butter(8,60/(Fs/2),'low');
v0 = filter(bl,al,vt);

V0f = abs(fft(v0))./(length(v0));
V0f = fftshift(V0f);


figure(4)
subplot(2,1,1)
plot(t,v0);
xlabel("time (s)");
ylabel("v_0(t)");
grid on;
subplot(2,1,2)
plot(f,V0f);
axis([-1000 1000 0 1.3]);
xlabel("frequency (Hz)");
ylabel("V_0(f)");
grid on;
