clc;
clear all;
close all;

F_s = 12e3;
dt = 1/F_s;
f_m = 400;    %modulating signal freq
f_c = 3e3;
T = 8 * (1/f_m);
t = 0:dt:T;
N = 1024;


A_m = 1.5;    %amplitude of modulating

a_1 = 0.4;
a_2 = 1;
a_3 = 1.8;

A_c_1 = A_m/a_1;
A_c_2 = A_m/a_2;
A_c_3 = A_m/a_3;





m_t = A_m * sin(2* pi * f_m * t); %modulating signal

c_t_1 = A_c_1 * cos(2* pi * f_c * t);
c_t_2 = A_c_2 * cos(2* pi * f_c * t);
c_t_3 = A_c_3 * cos(2* pi * f_c * t);

s_t_1 = A_c_1 .* (1 + a_1 * sin(2 * pi * f_m *t)) .* cos(2 * pi * f_c *t);
s_t_2 = A_c_2 .* (1 + a_2 * sin(2 * pi * f_m *t)) .* cos(2 * pi * f_c *t);
s_t_3 = A_c_3 .* (1 + a_3 * sin(2 * pi * f_m *t)) .* cos(2 * pi * f_c *t);

figure;
subplot(411)
plot(t,m_t,'LineWidth',2);
title('mesage signal');
xlabel('time');
ylabel('amplitude');
subplot(412)
plot(t,s_t_1,'LineWidth',2);
title('modulated signal 1');
xlabel('time');
ylabel('amplitude');
subplot(413)
plot(t,s_t_2,'LineWidth',2);
title('modulated signal 2');
xlabel('time');
ylabel('amplitude');
subplot(414)
plot(t,s_t_3,'LineWidth',2);
title('modulated signal 3');
xlabel('time');
ylabel('amplitude');

X_m_f = fft(m_t , N);
f_v = linspace(-F_s/2, F_s/2 , N);

figure;
subplot(311)
plot(f_v,abs(fftshift(X_m_f))/N);
title('magnitude response of m(t)');
xlabel('time');
ylabel('amplitude');

X_c_2_f = fft(c_t_2 , N);

subplot(312)
plot(f_v,abs(fftshift(X_c_2_f))/N);
title('magnitude response of c(t)');
xlabel('time');
ylabel('amplitude');
S_m_f = fft(s_t_2 , N);
subplot(313)
plot(f_v,abs(fftshift(S_m_f))/N);
title('magnitude response of s(t)');
xlabel('frequency');
ylabel('amplitude');

%---------3.3--------------

c_2 = c_t_2;
s_t = s_t_2;

s_t_sq = s_t .* s_t;
x_t = 2 .* s_t_sq;


[b_bandpass,a_bandpass] = butter(5,f_c / (F_s / 2),"low"); %Bandpass or lowpass
y_t = filter(b_bandpass,a_bandpass,abs(x_t));
r_t = sqrt(y_t);

figure;
subplot(311)
plot(t,x_t,'LineWidth',2);
title('x(t)');
xlabel('time');
ylabel('amplitude');
subplot(312)
plot(t,y_t,'LineWidth',2);
title('y(t)');
xlabel('time');
ylabel('amplitude');
subplot(313)
plot(t,r_t,'LineWidth',2);
title('r(t)');
xlabel('time');
ylabel('amplitude');

demodulated_m_t = r_t - 1.5;
figure;
plot(t,demodulated_m_t,'k');
hold on;
plot(t,m_t,'r');
title('m(t) and demodulated m(t)');
xlabel('time');
ylabel('amplitude');
legend('m(t)','cap m(t)')

