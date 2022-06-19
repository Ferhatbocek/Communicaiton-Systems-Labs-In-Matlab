clc;
Fs = 400;
duration = 5;
t = 0:1/Fs:duration;
t1 = 0:1/400:1;
t2 = 1.0005:1/400:2;
t3 = 2.0005:1/400:4;
t4 = 4.0005:1/400:5;
xt1 = 2*t1; 
xt2 = t2*0 + 2; 
xt3 = -t3 + 4;
xt4 = t4*0;
xt = [xt1 xt2 xt3 xt4];


%1b
tt = 1.5:1/400:4;
t11 = 1.5:1/400:2;
t22 = 2.0025:1/400:2.5;
t33 = 2.5025:1/400:3.5;
t44 = 3.5025:1/400:4;

xt11 = 2*2*(t11-1.5); 
xt22 = t22*0 + 2; 
xt33 = (-(t33-1.5))*2 + 4;
xt44 = t44*0;
x_2t = [xt11 xt22 xt33 xt44];
%a
figure;
plot(t,xt);
axis([0 5 -3 3]);
hold on;
plot(tt,x_2t);
grid on;
xlabel('time (s)');
ylabel('x(t)');
legend('x_1(t)','x_2(t)');
f=30;
yt1 = cos(2*pi*f*t);
yt = xt .* yt1;
figure;
plot(t,yt);
axis([0 5 -3 3]);
grid on;
xlabel('time (s)');
ylabel('y(t)');

%1.2

A=5;        phi = pi/6;         freq = 100;     Fsample = 4000;
%duration 50ms
n = 0:1:200;
n222 = 0:1:25;
tn = 0:1/4000:0.05;
tn2 = 0:8/4000:0.05;
xn = A*cos(2*pi*(freq/Fsample)*n + phi);
xn1 = A*cos(2*pi*(freq/Fsample)*n + 5*phi);
xn2 = A*cos(2*pi*(freq/(Fsample/8))*n222 + phi);
figure;
subplot(2,1,1);
plot(tn,xn,LineWidth=1);
hold on; grid on;
plot(tn,xn1,LineWidth=1);
legend('x[n]','x_1[n]');
subplot(2,1,2)
plot(tn,xn,LineWidth=1);
hold on; grid on;
plot(tn2,xn2,LineWidth=1);
xlabel('time (s)');
legend('x[n]','x_2[n]');


%c
t3n = 0:1/2000:0.5;
n3 = 0:1:1000;
x3n = cos(2*pi*(400/2000)*n);
frequency = linspace(-1000,1000,512);
Xf = abs(fft(x3n,512));
Xf1 = fftshift(Xf);
Xf1 = Xf1/max(Xf1);
figure
plot(frequency,Xf1);
grid on;
ylabel('Magnitude of X(f)');
xlabel('frequency (Hz)');




