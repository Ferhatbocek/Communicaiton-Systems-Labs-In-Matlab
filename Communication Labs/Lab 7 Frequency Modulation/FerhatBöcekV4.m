clc;
clear variables;
close all;

F_s = 4e3;
d = 0.5;
t = 0 : 1 / F_s : d;
N = length(t);
f = linspace(-F_s / 2, F_s / 2, N);
f_m = 40;
f_c = 150;
a = 3;

m_t = a * cos(2 * pi * f_m * t);
c_t = cos(2 * pi * f_c * t);

k = [6, 12, 18];

for i = 1 : 3
    % FM Modulation
    beta = (k(i) * a) / f_m;
    s_t = cos(2 * pi * f_c * t + beta * sin(2 * pi * f_m * t));

    % FM Demodulation
    m_d_t = a * fmdemod(s_t, f_c, F_s, k(i) * a);

    figure(1);
    subplot(4, 1, i + 1);
    plot(t, s_t);
    xlabel("t (s)");
    ylabel("s(t)");
    title("k = " + k(i));

    figure(2);
    subplot(4, 1, i + 1);
    plot(f, abs(fftshift(fft(s_t))) / N);
    xlabel("f (Hz)");
    ylabel("|S(f)|");
    title("k = " + k(i));

    figure(3);
    subplot(3, 1, i);
    plot(t, m_t);
    hold on;
    plot(t, m_d_t);
    legend("m(t)", "m_d(t)");
end

figure(1);
subplot(4, 1, 1);
plot(t, m_t);
xlabel("t (s)");
ylabel("m(t)");

figure(2);
subplot(4, 1, 1);
plot(f, abs(fftshift(fft(m_t))) / N);
xlabel("f (Hz)");
ylabel("|M(f)|");
