clc;
clear all;
close all;

%   Part 1
F_s = 3e3;
T = 0.6;
N = 512;
dt = 1/F_s;

n = 0:T/dt;

x_n = cos ( 2 * pi * 200/F_s * n) + sin (2 * pi * 500/F_s * n);

X_f = fft(x_n , N);
f_v = linspace(-F_s/2, F_s/2 , N);

figure;
plot(f_v,abs(fftshift(X_f))/N);
xlabel("f (hertz)");
ylabel("Magnitude");
%Part 2

F_s = 5e3;
T = 0.3;
dt = 1/F_s;
N = 1500;
n = 0:T/dt;

x_n = cos ( 2 * pi * 500/F_s * n) + 0.5 * sin (2 * pi * 1400/F_s * n);

X_f = fft(x_n , N);
f_v = linspace(-F_s/2, F_s/2 , N);

figure;
plot(f_v,abs(fftshift(X_f))/N);

[b_band,a_band]=butter(10,[300/(F_s/2),700/(F_s/2)],'bandpass');        % Bandpass digital filter design

%[B,A] = butter(N,Wn,'high') % designs a highpass filter.
[b_high,a_high]=butter(10,1000/(F_s/2),'high');

% Visualize filter
%h_band_pass = fvtool(b_band,a_band); 
%hold on;
%h_high = fvtool(b_high,a_high);

%Part a

h_bpf = freqz(b_band,a_band,F_s/2);
h_hpf = freqz(b_high,a_high,F_s/2);

figure;
plot(abs(h_bpf));
hold on;
plot(abs(h_hpf));
xlabel("f (hertz)");
ylabel("filter magnitude");

%Part b

y_band = filter(b_band,a_band,x_n);
y_high = filter(b_high,a_high,x_n);
figure;


plot(f_v,abs(fftshift(fft(y_band))) / N);
hold on;
plot(f_v,abs(fftshift(fft(y_high))) / N);
xlabel("f (hertz)");
ylabel("X_{HPF}(f) and X_{BPF}");












