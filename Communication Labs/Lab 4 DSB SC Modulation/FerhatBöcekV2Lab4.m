clc;
clear variables;
close all;

f_m = 80;
f_c = 600;
F_s = 10e3;

t = 0 : 1 / F_s : 250e-3;

m_t = 4 * cos(2 * pi * f_m * t);
c_t = cos(2 * pi * f_c * t);

s_t = m_t .* c_t;

figure;
subplot(3, 1, 1);
plot(t, m_t);
xlabel("t (s)");
ylabel("m(t)");
subplot(3, 1, 2);
plot(t, c_t);
xlabel("t (s)");
ylabel("c(t)");
subplot(3, 1, 3);
plot(t, s_t);
xlabel("t (s)");
ylabel("s(t)");

N = length(t);
f = linspace(-F_s / 2, F_s / 2, N);
big_m_f = fft(m_t);
big_s_f = fft(s_t);

figure;
subplot(2, 1, 1);
plot(f, abs(fftshift(big_m_f)) / N);
xlabel("f (Hz)");
ylabel("|M(f)|");
subplot(2, 1, 2);
plot(f, abs(fftshift(big_s_f)) / N);
xlabel("f (Hz)");
ylabel("|S(f)|");

v_t = s_t .* (2 * cos(2 * pi * (f_c + 40) * t));

big_v_f = fft(v_t);
figure;
plot(f, abs(fftshift(big_v_f)) / N);
xlabel("f (Hz)");
ylabel("|V(f)|");

[b, a] = butter(6, (f_c / 10) / (F_s / 2), "low");
v_o_t = filter(b, a, v_t);
big_v_o_f = fft(v_o_t);

figure;
subplot(2, 1, 1);
plot(t, v_o_t);
xlabel("t (s)");
ylabel("v_o(t)");
subplot(2, 1, 2);
plot(f, abs(fftshift(big_v_o_f)) / N);
xlabel("f (Hz)");
ylabel("|V_o(f)|");