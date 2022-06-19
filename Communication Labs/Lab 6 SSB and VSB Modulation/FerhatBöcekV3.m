clc;
clear variables;
close all;

F_s = 19e3;
t = 0 : 1 / F_s : 0.7;
f = linspace(-F_s / 2, F_s / 2, length(t));
f_m = 110;
m_t = cos(2 * pi * f_m * t);
f_c = 104;
c_t = cos(2 * pi * f_c * t);

s_t = m_t .* c_t;
figure;
plot(t, m_t);
hold on;
plot(t, c_t);
figure;
plot(t, s_t);

figure;
plot(f, abs(fftshift(fft(s_t))) / length(s_t));
xlabel("f (Hz)");
ylabel("|S(f)|");

% [b_23, a_23] = butter(23, (f_c) / (F_s / 2), "low");
% [b_4, a_4] = butter(4, f_c / (F_s / 2), "low");
% 
% figure;
% plot(abs(freqz(b_23, a_23, F_s / 2)));
% hold on;
% plot(abs(freqz(b_4, a_4, F_s / 2)));
% legend("n = 23", "n = 4");
% xlabel("f (Hz)");
% ylabel("|LPF(f)|");
% 
% s_lsb1 = filter(b_23, a_23, s_t);
% s_lsb2 = filter(b_4, a_4 , s_t);
% 
% figure;
% subplot(3, 1, 1);
% plot(f, abs(fftshift(fft(s_t))) / length(s_t));
% ylabel("|S(f)|");
% subplot(3, 1, 2);
% plot(f, abs(fftshift(fft(s_lsb1))) / length(s_lsb1));
% ylabel("|S_{LSB1}(f)|");
% subplot(3, 1, 3);
% plot(f, abs(fftshift(fft(s_lsb2))) / length(s_lsb2));
% ylabel("|S_{LSB2}(f)|");
% 
% v_t = s_lsb1 .* (4 * cos(2 * pi * f_c * t));
% 
% [b, a] = butter(27, 2800 / (F_s / 2), "low");
% 
% figure;
% subplot(2, 1, 1);
% plot(f, abs(fftshift(fft(m_t))) / length(m_t));
% ylabel("|M(f)|");
% subplot(2, 1, 2);
% plot(f, abs(fftshift(fft(filter(b, a, v_t)))) / length(v_t));
% ylabel("|M_d_1(f)|");
% xlabel("f (Hz)");
% 
% figure;
% plot(t, m_t);
% hold on;
% plot(t, filter(b, a, v_t));
% legend("m(t)", "m_d(t)");