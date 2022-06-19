clc;
clear all;
close all;

F_s = 4e3;
dt = 1/F_s;
f_m = 40;   
f_c = 150;
T = 0.5;
t = 0:dt:T;
N = length(t);
f_v = linspace(-F_s/2,F_s/2,N);
A_m = 3;
A_c = 1;

c_t = A_c*cos(2*pi*f_c*t) ;
m_t = A_m*cos(2*pi*f_m*t) ;

k_f1 = 6;
k_f2 = 12;
k_f3 = 18;


%{
cum = cumsum(m_t)*(1/F_s) ;

s1_cum = A_c*cos(2*pi*f_c*t+2*pi*k_f1*cum) ;
s2_cum= A_c*cos(2*pi*f_c*t+2*pi*k_f2*cum) ;
s3_cum= A_c*cos(2*pi*f_c*t+2*pi*k_f3*cum) ;
%}

s1_t = A_c*cos(2*pi*f_c*t+2*pi*k_f1*3/(2*pi*f_m)*sin(2*pi*f_m*t)) ;
s2_t = A_c*cos(2*pi*f_c*t+2*pi*k_f2*3/(2*pi*f_m)*sin(2*pi*f_m*t)) ;
s3_t = A_c*cos(2*pi*f_c*t+2*pi*k_f3*3/(2*pi*f_m)*sin(2*pi*f_m*t)) ;

%{
figure(4);
subplot(411);
plot(t,m_t);
xlabel("time");
ylabel("magnitude");
title("m");
subplot(412);
plot(t,s1_cum);
xlabel("time");
ylabel("magnitude");
title("kf=6");
subplot(413);
plot(t,s2_cum);
xlabel("time");
ylabel("magnitude");
title("kf=12");
subplot(414);
plot(t,s3_cum);
xlabel("time");
ylabel("magnitude");
title("kf=18");
%}

figure(1);
subplot(411);
plot(t,m_t);
xlabel("time");
ylabel("magnitude");
title("m");
subplot(412);
plot(t,s1_t);
xlabel("time");
ylabel("magnitude");
title("kf=6");
subplot(413);
plot(t,s2_t);
xlabel("time");
ylabel("magnitude");
title("kf=12");
subplot(414);
plot(t,s3_t);
xlabel("time");
ylabel("magnitude");
title("kf=18");

%% Part 2 %%

M_fft = fft(m_t, N);
M_fft = fftshift(M_fft);
M_fft = abs(M_fft)/N;

S1_fft = fft(s1_t, N);
S1_fft = fftshift(S1_fft);
S1_fft = abs(S1_fft)/N;

S2_fft = fft(s2_t, N);
S2_fft = fftshift(S2_fft);
S2_fft = abs(S2_fft)/N;

S3_fft = fft(s3_t, N);
S3_fft = fftshift(S3_fft);
S3_fft = abs(S3_fft)/N;

figure(2);
subplot(411);
plot(f_v,M_fft);
xlabel("frequency");
ylabel("magnitude");
title("FFT of m");

subplot(412) ;
plot(f_v,S1_fft);
xlabel("frequency") ;
ylabel("magnitude") ;
title("FFT of S1") ;
subplot(413) ;
plot(f_v,S2_fft) ;
xlabel("frequency") ;
ylabel("magnitude") ;
title("FFT of S2") ;
subplot(414) ;
plot(f_v,S3_fft) ;
xlabel("frequency") ;
ylabel("magnitude") ;
title("FFT of S3") ;

%% Part 3 %% 

sdemod1=A_m*fmdemod(s1_t,f_c,F_s,A_m*k_f1);
sdemod2=A_m*fmdemod(s2_t,f_c,F_s,A_m*k_f2);
sdemod3=A_m*fmdemod(s3_t,f_c,F_s,A_m*k_f3);

figure(3);
subplot(311);
plot(t,sdemod1);
hold on;
plot(t,m_t);
xlabel("time");
ylabel("magnitude");
legend('sdemod1','m');
title("m,sdemod1 with kf=6");
subplot(312);
plot(t,sdemod2);
hold on;
plot(t,m_t);
xlabel("time");
ylabel("magnitude");
legend('sdemod2','m');
title("m,sdemod2 with kf=12");
subplot(313);
plot(t,sdemod3);
hold on;
plot(t,m_t);
xlabel("time");
ylabel("magnitude");
legend('sdemod3','m');
title("m,sdemod3 with kf=18");

