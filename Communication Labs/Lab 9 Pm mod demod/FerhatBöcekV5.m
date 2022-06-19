clc;
clear variables;
close all;

A_m = 1;
f_m = 30;
F_s = 6e3;
d = 0.5;
t = 0 : 1 / F_s : d;

m_t = A_m * cos(2 * pi * f_m * t);

A_u = 5;
f_c = 300;
k_p = [pi / 2, pi, 3 * pi / 2];
B_p = k_p * A_m;

figure(1);
subplot(4, 1, 1);
plot(t, m_t);
xlabel("t (s)");
ylabel("m(t)");

for i = 1:3
    u = A_u * cos(2 * pi * f_c * t + B_p(i) * m_t);
    figure(1);
    subplot(4, 1, i + 1);
    plot(t, u);
    xlabel("t (s)");
    ylabel("u_" + i + "(t)");

    figure(2);
    ru = awgn(u, 5, "measured");
    subplot(3, 1, i);
    plot(t, ru);
    xlabel("t (s)");
    ylabel("ru_" + i + "(t)");

    figure(3);
    yu = pmdemod(ru, f_c, F_s, k_p(i));
    subplot(3, 1, i);
    plot(t, yu);
    xlabel("t (s)");
    ylabel("yu_" + i + "(t)");

    figure(4);
    [b, a] = butter(8, 60 / F_s, "low");
    p = 1.6;
    if i == 2
        p = 2.32;
    elseif i == 3
        p = 6.66;
    end
    y = filter(b, a, yu);
    subplot(3, 1, i);
    plot(t, m_t);
    xlabel("t (s");
    hold on;
    plot(t, p * y);
    xlabel("t (s)");
    legend("m(t)", "y_" + i + "(t)");
    hold off;
end