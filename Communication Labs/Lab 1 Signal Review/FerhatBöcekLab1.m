clc;
clear all;
close all;
% 0,5 .. -3,3
% 1.1
F_s = 400;
dt = 1 / F_s;
t = 0 : dt : 5;

x_t = zeros(1, length(t));
x_t_2 = zeros(1, length(t));

i = 1;
for tl = 0 : dt : 5
    if (tl >= 0 && tl <= 1)
        x_t(i) = 2 * tl;
    elseif (tl > 1 && tl <= 2)
        x_t(i) = 2;
    elseif (tl > 2 && tl <= 4)
        x_t(i) = -tl + 4;
    end

    u = (2*tl - 3);
    if (u >= 0 && u <= 1)
        x_t_2(i) = 2 * u;
    elseif (u > 1 && u <= 2)
        x_t_2(i) = 2;
    elseif (u > 2 && u <= 4)
        x_t_2(i) = -u + 4;
    end
    i = i + 1;
end

figure;
plot(t, x_t);
xlabel("t (seconds)");
ylabel("x(t)");
ylim([-3, 3]);

figure;
hold on;
plot(t, x_t);
xlabel("t (seconds)");
ylim([-3, 3]);
plot(t, x_t_2);
legend("x(t)", "x_2(t)");

y_t = x_t .* cos(2 * pi * 30 * t);

figure;
plot(t, y_t);
ylim([-3, 3]);
xlabel("t (seconds)");
ylabel("y(t)");

% 1.2
A = 5;
theta = pi / 6;
f = 100;
F_s = 4e3;
n = 0 : length(0 : 1 / F_s : 50e-3) - 1; 
n2 = 0 : length(0 : 1 / (F_s / 8) : 50e-3) - 1;

x_n = A * cos(2 * pi * (f / F_s) * n + theta);
x_n_2 = A * cos(2 * pi * (f / F_s) * n + (5 * theta));
x_n_3 = A * cos(2 * pi * (8 * f / F_s) * n2 + theta);

figure;
subplot(3, 1, 1);
hold on;
stem(n, x_n);
stem(n, x_n_2);
xlabel("n");
ylabel("x[n]");
legend("\theta_1 = \theta", "\theta_2 = 5\theta");
subplot(3, 1, 2);
stem(n, x_n);
xlabel("n");
ylabel("x[n]");
legend("F_{s1} = F_s");
subplot(3, 1, 3);
stem(n2, x_n_3);
xlabel("n");
ylabel("x[n]");
legend("F_{s2} = F_s / 8")


A = 1;
f = 400;
F_s = 2e3;
n = 0 : length(0 : 1 / F_s : 500e-3);

x_n_4 = A * cos(2 * pi * (f / F_s) * n);
N = 512;
big_x_w = fft(x_n_4, N);
f_v = linspace(-F_s / 2, F_s / 2, N);

figure;
plot(f_v, abs(fftshift(big_x_w)) / N);
xlabel("f (Hz)");
ylabel("X(f)");