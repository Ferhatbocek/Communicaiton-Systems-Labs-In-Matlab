clc 
clear;
clearvars;

d = 0.5;
fc=300;
fs = 6000;
Ts = 1/fs;
t = 0 : Ts: d;
N = length(t);
fv = linspace(-fs/2,fs/2,N);

fm=30;

Am=1;
Au=5;

mt=Am*cos(2*pi*fm*t);


kp = [pi/2, pi, (3*pi)/2];

u1 = Au*cos(2*pi*fc*t + kp(1)*mt);
u2 = Au*cos(2*pi*fc*t + kp(2)*mt);
u3 = Au*cos(2*pi*fc*t + kp(3)*mt);



figure()
subplot(411);
plot(t,mt);
title('m(t)');
xlabel('Time (sec)');
ylabel(' Amplitude');


subplot(412);
plot(t,u1);
title('u_{PM}(t)');
xlabel('Time (sec)');
ylabel(' Amplitude');

subplot(413);
plot(t,u2);
title('u_{PM_{2}}(t)');
xlabel('Time (sec)');
ylabel(' Amplitude');

subplot(414);
plot(t,u3);
title('u_{PM_{3}}(t)');
xlabel('Time (sec)');
ylabel(' Amplitude');




%% 1.2 AWGN Channel

y1= awgn(u1,5,'measured');
y2= awgn(u2,5,'measured');
y3= awgn(u3,5,'measured');


figure()
subplot(311);
plot(t, y1);
title('u1(t)');
xlabel("time (s)");
ylabel("ru_1(t)");
grid on;


subplot(312);
plot(t, y2);
legend('Signal with AWGN')
title('u2(t)');
xlabel("time (s)");
ylabel("ru_2(t)");
grid on;

subplot(313);
plot(t, y3);
legend('Signal with AWGN')
title('u3(t)');
xlabel("time (s)");
ylabel("ru_3(t)");
grid on;

%% 1.3 PM Demodulation 

yu1 = pmdemod(y1,fc,fs,kp(1));
yu2 = pmdemod(y2,fc,fs,kp(2));
yu3 = pmdemod(y3,fc,fs,kp(3));

figure()
subplot(311);
plot(t, yu1);


subplot(312);
plot(t, yu2);

subplot(313);
plot(t, yu3);


