clc;
clear variables;
close all;

A_m = 1.5;
f_m = 400;
f_c = 3e3;

F_s = 12e3;
t = 0 : 1 / F_s : 8 / f_m;

m_t = A_m * sin(2 * pi * f_m * t);

mod_indices = [0.4, 1, 1.8];

figure;
subplot(4, 1, 1);
plot(t, m_t);
xlabel("t (s)");
ylabel("m(t)");

for i = 1 : 3
    A_c = A_m / mod_indices(i);
    s_t = A_c * (1 + mod_indices(i) * sin(2 * pi * f_m * t)) .* cos(2 * pi * f_c * t);

    subplot(4, 1, i + 1);
    plot(t, s_t);
    xlabel("t (s)");
    ylabel("s(t)");
    title("\mu = " + sprintf("%.1f", mod_indices(i)));
end
A_c = A_m;
f = linspace(-F_s / 2, F_s / 2, 1024);
big_m_f = abs(fftshift(fft(m_t, 1024)) / 1024);

c_t = A_c * cos(2 * pi * f_c * t);
big_c_f = abs(fftshift(fft(c_t, 1024)) / 1024);

s_t = A_c * (1 + sin(2 * pi * f_m * t)) .* cos(2 * pi * f_c * t);
big_s_f = abs(fftshift(fft(s_t, 1024)) / 1024);

figure;
subplot(3, 1, 1);
plot(f, big_m_f);
xlabel("f (Hz)");
ylabel("|M(f)|");
subplot(3, 1, 2);
plot(f, big_c_f);
xlabel("f (Hz)");
ylabel("|C(f)|");
subplot(3, 1, 3);
plot(f, big_s_f);
xlabel("f (Hz)");
ylabel("|S(f)|");

x_t = 2 .* (s_t .* s_t);
[b,a] = butter(5, f_c / (F_s / 2), "low");
y_t = filter(b, a, x_t);
r_t = abs(y_t) .^ (1/2);
figure;
subplot(3, 1, 1);
plot(t, x_t);
xlabel("t (s)");
ylabel("x(t)");
subplot(3, 1, 2);
plot(t, y_t);
xlabel("t (s)");
ylabel("y(t)");
subplot(3, 1, 3);
plot(t, r_t);
xlabel("t (s)");
ylabel("r(t)");

m_d_t = r_t - mean(r_t);
figure;
plot(t, m_t);
hold on;
plot(t, m_d_t);
xlabel("t (s)");
legend("m(t)", "$\hat{m}$(t)", "Interpreter", "latex");
