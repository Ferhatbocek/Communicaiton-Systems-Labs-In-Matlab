clc;
close all;
Fs = 6000;  fm = 30;  fc = 300;
Ts = 1/Fs;
t = 0:Ts:0.5;
N = length(t);
f = linspace(-Fs/2,Fs/2,N);
kp = [pi/2 pi (3*pi)/2];
mt = cos(2*pi*fm*t);
bp = kp;

ut1 = 5*cos(2*pi*fc*t + (kp(1).*mt));
ut2 = 5*cos(2*pi*fc*t + (kp(2).*mt));
ut3 = 5*cos(2*pi*fc*t + (kp(3).*mt));

figure(1);
subplot(4,1,1);
plot(t,mt);
xlabel("time (s)");
ylabel("m(t)");
grid on;

subplot(4,1,2);
plot(t,ut1);
xlabel("time (s)");
ylabel("u_1(t)");
grid on;

subplot(4,1,3);
plot(t,ut2);
xlabel("time (s)");
ylabel("u_2(t)");
grid on;

subplot(4,1,4);
plot(t,ut3);
xlabel("time (s)");
ylabel("u_3(t)");
grid on;

ru1t = awgn(ut1,5,'measured');
ru2t = awgn(ut2,5,'measured');
ru3t = awgn(ut3,5,'measured');

figure(2);
subplot(3,1,1);
plot(t,ru1t);
xlabel("time (s)");
ylabel("ru_1(t)");
grid on;

subplot(3,1,2);
plot(t,ru2t);
xlabel("time (s)");
ylabel("ru_2(t)");
grid on;

subplot(3,1,3);
plot(t,ru3t);
xlabel("time (s)");
ylabel("ru_3(t)");
grid on;

yu1 = pmdemod(ru1t,fc,Fs,kp(1));
yu2 = pmdemod(ru2t,fc,Fs,kp(2));
yu3 = pmdemod(ru3t,fc,Fs,kp(3));

figure(3);
subplot(3,1,1);
plot(t,yu1);
xlabel("time (s)");
ylabel("yu_1(t)");
grid on;

subplot(3,1,2);
plot(t,yu2);
xlabel("time (s)");
ylabel("yu_2(t)");
grid on;

subplot(3,1,3);
plot(t,yu3);
xlabel("time (s)");
ylabel("yu_3(t)");
grid on;

[bl,al] = butter(8,30/(Fs/2),'low');
yu1filtered = filter(bl,al,yu1);
yu2filtered = filter(bl,al,yu2);
yu3filtered = filter(bl,al,yu3);

scaling_fact = [abs(mt(1500)/yu1filtered(1500)) abs(mt(1500)/yu2filtered(1500)) abs(mt(1500)/yu3filtered(1500))];

yu1filtered = yu1filtered.*scaling_fact(1);
yu2filtered = yu2filtered.*scaling_fact(2);
yu3filtered = yu3filtered.*scaling_fact(3);


figure(4);
subplot(3,1,1);
plot(t,yu1filtered);
hold on;
plot(t,mt);
xlabel("time (s)");
legend("y_1(t)","m(t)");
grid on;

subplot(3,1,2);
plot(t,yu2filtered);
hold on;
plot(t,mt);
xlabel("time (s)");
legend("y_2(t)","m(t)");
grid on;

subplot(3,1,3);
plot(t,yu3filtered);
hold on;
plot(t,mt);
xlabel("time (s)");
legend("y_3(t)","m(t)");
grid on;