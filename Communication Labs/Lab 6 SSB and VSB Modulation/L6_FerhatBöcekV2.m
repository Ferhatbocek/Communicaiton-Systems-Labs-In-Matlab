clc;
clear all;
close all;

F_s = 19e3;
dt = 1/F_s;
f_m = 300;    %modulating signal freq
f_c = 6e3;
T = 0.04;
t = 0:dt:T;
N = length(t);

m_t = 5 * cos( 2* pi * f_m * t);
c_t = cos( 2 * pi * f_c * t);
s_t_dsb = m_t .* c_t;

[b_low a_low] = butter( 4 , (f_c)/(F_s/2) ,"low");
[b_low_2 a_low_2] = butter(23,(f_c)/(F_s/2),"low");


h_low = freqz(b_low, a_low, F_s/2);
h_high = freqz(b_low_2, a_low_2, F_s/2);

figure(1) ;
plot(abs(h_low)) ;
hold on ;
plot(abs(h_high)) ;
legend('n_1 < 4','n_2 > 23');
title('filters');

s_lsb1 = filter(b_low,a_low,s_t_dsb);
s_lsb2 = filter(b_low_2,a_low_2,s_t_dsb);

%{
figure(2)
subplot(311)
plot(t,s_t_dsb);
subplot(312)
plot(t,s_lsb1);
subplot(313)
plot(t,s_lsb2);
%}

f_v = linspace(-F_s/2, F_s/2 , N);

S_f = fft(s_t_dsb,N);
S_f = abs((fftshift(S_f))/N);

S_lsb1_f = fft(s_lsb1,N);
S_lsb1_f = abs((fftshift(S_lsb1_f))/N);

S_lsb2_f = fft(s_lsb2,N);
S_lsb2_f = abs((fftshift(S_lsb2_f))/N);


figure(2)
subplot(311)
plot(f_v,S_f);
xlabel("frequency") ;
ylabel("Magnitude") ;
title("FFT of S") ;
subplot(312)
plot(f_v,S_lsb1_f);
xlabel("frequency") ;
ylabel("Magnitude") ;
title("FFT of S(lsb1)") ;
subplot(313)
plot(f_v,S_lsb2_f);
xlabel("frequency") ;
ylabel("Magnitude") ;
title("FFT of S(lsb2)") ;

%----------------
%{
s_lsb1_t = ifft(s_lsb1); %vsb
s_lsb2_t = ifft(s_lsb2); %ssb
%}

%{
figure
plot(t,s_lsb1);
figure
plot(t,s_lsb2);
figure
plot(t,s_t_dsb);
%}

u_ssb_t = s_lsb2 .* c_t .*4 ;

[b_low_dem a_low_dem] = butter( 4 , (2*f_m)/(F_s/2) ,"low");

demodulated_s_t = filter(b_low_dem,a_low_dem,u_ssb_t);

demodulated_S_f = fft(demodulated_s_t,N);
demodulated_S_f = abs((fftshift(demodulated_S_f))/N);

M_f = fft(m_t,N);
M_f = abs((fftshift(M_f))/N);

figure(3)
subplot(211)
plot(f_v,demodulated_S_f);
xlabel("frequency") ;
ylabel("Magnitude") ;
title("frequency response of demodulated m_t") ;
subplot(212)
plot(f_v,M_f);
xlabel("frequency") ;
ylabel("Magnitude") ;
title("frequency response of m_t") ;

figure(4)
plot(t,m_t);
xlabel("time") ;
ylabel("Magnitude") ;
title("s(t)") ;
hold on
plot(t,demodulated_s_t);
xlabel("time") ;
ylabel("Magnitude") ;
title("demodulated s(t)") ;

