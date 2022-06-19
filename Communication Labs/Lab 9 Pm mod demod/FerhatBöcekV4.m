clc;
clear all;
close all;

%% Part1 %%
Fs = 6e3 ;
f_m = 30;
f_c = 300;
kp_1 = pi/2;
kp_2 = pi;
kp_3 = 3 * pi / 2;
t = 0: 1/Fs: 0.5;

m_t = cos( 2 * pi * f_m * t);

ut_1 = 5 * cos( 2 * pi * f_c * t + kp_1 * m_t);
ut_2 = 5 * cos( 2 * pi * f_c * t + kp_2 * m_t);
ut_3 = 5 * cos( 2 * pi * f_c * t + kp_3 * m_t);

figure(1) ;
subplot(411) ;
plot(t,m_t) ;
title("m(t)") ;
ylabel("magnitude") ;
xlabel("time") ;
subplot(412) ;
plot(t,ut_1) ;
title("u(t1), kp=pi/2") ;
ylabel("magnitude") ;
xlabel("time") ;
subplot(413) ;
plot(t,ut_2) ;
title("u(t2), kp =pi") ;
ylabel("magnitude") ;
xlabel("time") ;
subplot(414) ;
plot(t,ut_3) ;
title("u(t3), kp =3*pi/2") ;
ylabel("magnitude") ;
xlabel("time") ;

%% Part2

rut_1 = awgn(ut_1 , 5); 
rut_2 = awgn(ut_2 , 5);
rut_3 = awgn(ut_3 , 5);

figure(2) ;
subplot(311) ;
plot(t,rut_1) ;
title("noise ru_1") ;
ylabel("magnitude") ;
xlabel("time") ;
subplot(312) ;
plot(t,rut_2) ;
title("noise ru_2") ;
ylabel("magnitude") ;
xlabel("time") ;
subplot(313) ;
plot(t,rut_3) ;
title("noise ru_3") ;
ylabel("magnitude") ;
xlabel("time") ;

%% Part3

rut_1dm= pmdemod(rut_1 , f_c , Fs, kp_1);
rut_2dm= pmdemod(rut_2 , f_c , Fs, kp_2);
rut_3dm= pmdemod(rut_3 , f_c , Fs, kp_3);

figure(3) ;
subplot(311) ;
plot(t,rut_1dm) ;
title("noise demodulated ru_1") ;
ylabel("magnitude") ;
xlabel("time") ;
subplot(312) ;
plot(t,rut_2dm) ;
title("noise demodulated ru_2") ;
ylabel("magnitude") ;
xlabel("time") ;
subplot(313) ;
plot(t,rut_3dm) ;
title("noise demodulated ru_3") ;
ylabel("magnitude") ;
xlabel("time") ;

[b_low_dem a_low_dem] = butter( 8 , (2 * f_m)/(Fs) ,"low");

demodulated_flt_u1 = 1.5*filter(b_low_dem,a_low_dem,rut_1dm);
demodulated_flt_u2 = 1.7*filter(b_low_dem,a_low_dem,rut_2dm);
demodulated_flt_u3 = 5*filter(b_low_dem,a_low_dem,rut_3dm);

figure(4) ;
subplot(311) ;
plot(t,m_t) ;
hold on;
plot(t,demodulated_flt_u1);
title("m_t and filtered u1") ;
ylabel("magnitude") ;
xlabel("time") ;
subplot(312) ;
plot(t,m_t) ;
hold on;
plot(t,demodulated_flt_u2);
title("m_t and filtered u1") ;
ylabel("magnitude") ;
xlabel("time") ;
subplot(313) ;
plot(t,m_t) ;
hold on;
plot(t,demodulated_flt_u3);
title("m_t and filtered u3") ;
ylabel("magnitude") ;
xlabel("time") ;
