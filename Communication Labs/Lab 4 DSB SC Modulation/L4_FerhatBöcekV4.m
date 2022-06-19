clc;
clear all;
close all;

F_s = 10e3;
dt = 1/F_s;
f_m = 80;    %modulating signal freq
f_c = 600;
T = 0.25;
t = 0:dt:T;
N = length(t);

m_t = 4 * cos(2*pi*f_m*t);
c_t = cos(2*pi*f_c*t);

s_t = m_t .* c_t;

subplot(311)

plot(t,m_t);
xlabel('time');
ylabel('Amplitude');
title('m(t)');

subplot(312)

plot(t,c_t);
xlabel('time');
ylabel('Amplitude');
title('c(t)');

subplot(313)
plot(t,s_t);
xlabel('time');
ylabel('Amplitude');
title('s(t)');

f_v = linspace(-F_s/2, F_s/2 , N);

M_f = fft(m_t,N);
M_f = abs((fftshift(M_f))/N);

S_f = fft(s_t,N);
S_f = abs((fftshift(S_f))/N);

figure;
subplot(211)
plot(f_v,M_f);
title('magnitude response of m(f)');
xlabel('time');
ylabel('amplitude');
subplot(212)
plot(f_v,S_f);
title('magnitude response of s(f)');
xlabel('time');
ylabel('amplitude');


%---------Demodulation------------

v_t = s_t .* cos( 2* pi * (f_c + 40) * t ) .*2;

V_f = fft(v_t,N);
V_f = abs((fftshift(V_f))/N);

figure;
plot(f_v,V_f);
xlabel('frequency');
ylabel('Amplitude');
title('V(f) (magnitude response of v(t))');


[b_low,a_low] = butter( 8 , 50 / ( F_s / 2) ,'low');

h_low = freqz(b_low, a_low, F_s/2);

%figure;
%plot(abs(h_low));

v_0_t = filter(b_low,a_low,v_t);

V_0_f = fft(v_0_t,N);
V_0_f = abs((fftshift(V_0_f))/N);


%figure
%plot(f_v,V_0_f);
%title('magnitude response of v(0_f)');


figure;
subplot(211)
plot(t,v_0_t);
xlabel('time');
ylabel('Amplitude');
title('V_0_t');
subplot(212)
plot(f_v,V_0_f);
xlabel('frequency');
ylabel('Amplitude');
title('V_0_f');
















