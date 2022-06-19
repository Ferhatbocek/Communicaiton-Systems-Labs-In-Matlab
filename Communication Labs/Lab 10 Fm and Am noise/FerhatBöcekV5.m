clc;
clear variables;
close all;

% 10.1
image = imread("cameraman.tif");
image_data = im2double(image);

F_s = length(image_data)^2;
m_t = reshape(image_data, [1, F_s]);

t = linspace(0, 1, length(m_t));
f = linspace(-F_s / 2, F_s / 2, length(m_t));

figure(1);
plot(f, abs(fftshift(fft(m_t))) / length(m_t));
xlabel("f (Hz)");
ylabel("|M(f)|");

% 10.2
a_c_dsb = 1;
f_c_dsb = 16e3;
c_t_dsb = a_c_dsb * cos(2 * pi * f_c_dsb * t);
s_t_dsb = m_t .* c_t_dsb;

a_c_fm = 1;
f_c_fm = 4e3;
k_f = 27e3;
s_t_fm = a_c_fm * cos(2 * pi * f_c_fm * t + (2 * pi * k_f * cumsum(m_t) * (1 / F_s)));

snr = [0, 5, 10, 20, 30];

% 10.3
for i = 1 : 5
    r_t_dsb = awgn(s_t_dsb, snr(i), "measured");
    r_t_fm = awgn(s_t_fm, snr(i), "measured");

    v_t_dsb = 2 * r_t_dsb .* c_t_dsb;
    [b, a] = butter(2, 0.5 * f_c_dsb / (F_s / 2), "low");
    m_t_dsb_demod = filter(b, a, v_t_dsb);

    m_t_fm_demod = fmdemod(r_t_fm, f_c_fm, F_s, k_f);

    image_data_dsb = reshape(m_t_dsb_demod, [length(image_data), length(image_data)]);
    image_data_fm = reshape(m_t_fm_demod, [length(image_data), length(image_data)]);

    if i == 3
        figure(2);
        subplot(2, 1, 1);
        plot(f, abs(fftshift(fft(m_t_dsb_demod))) / length(m_t_dsb_demod));
        title("SNR = 10dB");
        xlabel("f (Hz)");
        ylabel("|M_{dsb_{demod}}(f)|");
        subplot(2, 1, 2);
        plot(f, abs(fftshift(fft(m_t_fm_demod))) / length(m_t_fm_demod));
        xlabel("f (Hz)");
        ylabel("|M_{fm_{demod}}(f)|");
    end

    figure(3);
    subplot(2, 5, i);
    imshow(image_data_dsb);
    title(num2str(psnr(image_data_dsb, image_data)));
    subplot(2, 5, i + 5);
    imshow(image_data_fm);
    title(num2str(psnr(image_data_fm, image_data)));
end

% 10.4.a
k_f = 1e3 : 1e3 : 32e3;
psnr_fm = zeros(1, length(k_f));
for i = 1 : length(k_f)
    s_t_fm = a_c_fm * cos(2 * pi * f_c_fm * t + (2 * pi * k_f(i) * cumsum(m_t) * (1 / F_s))); 
    r_t_fm = awgn(s_t_fm, snr(5), "measured");
    m_t_fm_demod = fmdemod(r_t_fm, f_c_fm, F_s, k_f(i));
    image_data_fm = reshape(m_t_fm_demod, [length(image_data), length(image_data)]);

    psnr_fm(i) = psnr(image_data_fm, image_data);
end

figure(4);
plot(k_f, psnr_fm);
xlabel("k_f");
ylabel("PSNR");

% 10.4.b
f_c_dsb = 32.5e3;
c_t_dsb = a_c_dsb * cos(2 * pi * f_c_dsb * t);
s_t_dsb = m_t .* c_t_dsb;
r_t_dsb = awgn(s_t_dsb, snr(5), "measured");

v_t_dsb = 2 * r_t_dsb .* c_t_dsb;
[b, a] = butter(2, 0.5 * f_c_dsb / (F_s / 2), "low");
m_t_dsb_demod = filter(b, a, v_t_dsb);

image_data_dsb = reshape(m_t_dsb_demod, [length(image_data), length(image_data)]);
figure(5);
imshow(image_data_dsb);
title(num2str(psnr(image_data_dsb, image_data)));

% 10.4.c
t_upsampled = linspace(0, 1, 2 * F_s);
m_t_upsampled = reshape([image_data; image_data], [1, 2 * F_s]);
c_t_dsb_upsampled = a_c_dsb * cos(2 * pi * f_c_dsb * t_upsampled);
s_t_dsb_upsampled = m_t_upsampled .* c_t_dsb_upsampled;
r_t_dsb = awgn(s_t_dsb_upsampled, snr(5), "measured");

v_t_dsb = 2 * r_t_dsb .* c_t_dsb_upsampled;
