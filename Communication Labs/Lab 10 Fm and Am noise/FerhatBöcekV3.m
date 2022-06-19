clc;
clear all;
close all;

%% 10.1

data=imread('cameraman.tif');
M=im2double(data);
y=reshape(M,1,256*256);
Fs=length(y);
t=0:1/Fs:(numel(y)-1)/Fs;
N = length(t);
f_v = linspace(-Fs/2,Fs/2,N);

M_fft = fft(y, N);
M_fft = fftshift(M_fft);
M_fft = abs(M_fft)/N;

figure(1)
plot(f_v,M_fft);

%% 10.2

f_cdsb = 16e3;
f_cfm = 4e3;
kf = 27e3;

c = cos(2*pi*16*f_cdsb*t);

dsbsc=y.*c;
s_fm = cos(2 * pi * f_cfm * t + 2 * pi * kf * (1/Fs) * cumsum(y));

dsbsc1=awgn(dsbsc,0,'measured');
dsbsc2=awgn(dsbsc,5,'measured');
dsbsc3=awgn(dsbsc,10,'measured');
dsbsc4=awgn(dsbsc,20,'measured');
dsbsc5=awgn(dsbsc,30,'measured');

s_fm1 = awgn(s_fm,0,'measured');
s_fm2 = awgn(s_fm,5,'measured');
s_fm3 = awgn(s_fm,10,'measured');
s_fm4 = awgn(s_fm,20,'measured');
s_fm5 = awgn(s_fm,30,'measured');


%% 10.3

v1=dsbsc1 .*c;
v2=dsbsc2.*c;
v3=dsbsc3.*c;
v4=dsbsc4.*c;
v5=dsbsc5.*c;

[b, a] = butter(2, 0.5 * f_cdsb / (Fs / 2), "low");

v01=filter(b,a,v1);
v02=filter(b,a,v2);
v03=filter(b,a,v3);
v04=filter(b,a,v4);
v05=filter(b,a,v5);

s_fm1_t=fmdemod(s_fm1,f_cfm,Fs,kf);
s_fm2_t=fmdemod(s_fm2,f_cfm,Fs,kf);
s_fm3_t=fmdemod(s_fm3,f_cfm,Fs,kf);
s_fm4_t=fmdemod(s_fm4,f_cfm,Fs,kf);
s_fm5_t=fmdemod(s_fm5,f_cfm,Fs,kf);

DSB3 = fft(v03, N);
DSB3 = fftshift(DSB3);
DSB3 = abs(DSB3)/N;

S3_fft = fft(s_fm3_t, N);
S3_fft = fftshift(S3_fft);
S3_fft = abs(S3_fft)/N;

figure(2)
subplot(211)
plot(f_v,DSB3);
subplot(212)
plot(f_v,S3_fft);

dsb_demodulated1=reshape(v01,length(data),length(data));
dsb_demodulated2=reshape(v02,length(data),length(data));
dsb_demodulated3=reshape(v03,length(data),length(data));
dsb_demodulated4=reshape(v04,length(data),length(data));
dsb_demodulated5=reshape(v05,length(data),length(data));

sfm1_demodulated1=reshape(s_fm1_t,length(data),length(data));
sfm2_demodulated2=reshape(s_fm2_t,length(data),length(data));
sfm3_demodulated3=reshape(s_fm3_t,length(data),length(data));
sfm4_demodulated4=reshape(s_fm4_t,length(data),length(data));
sfm5_demodulated5=reshape(s_fm5_t,length(data),length(data));

a= num2str(psnr(dsb_demodulated1,M));

figure();

subplot(2,5,1);
imshow(dsb_demodulated1);
title(num2str(psnr(dsb_demodulated1, M)));
subplot(2,5,2);
imshow(dsb_demodulated2);
title(num2str(psnr(dsb_demodulated2,M)));
subplot(2,5,3);
imshow(dsb_demodulated3);
title(num2str(psnr(dsb_demodulated3,M)));
subplot(2,5,4);
imshow(dsb_demodulated4);
title(num2str(psnr(dsb_demodulated4,M)));
subplot(2,5,5);
imshow(dsb_demodulated5);
title(num2str(psnr(dsb_demodulated5,M)));

subplot(2,5,6);
imshow(sfm1_demodulated1);
title(num2str(psnr(sfm1_demodulated1,M)));
subplot(2,5,7);
imshow(sfm2_demodulated2);
title(num2str(psnr(sfm2_demodulated2,M)));
subplot(2,5,8);
imshow(sfm3_demodulated3);
title(num2str(psnr(sfm3_demodulated3,M)));
subplot(2,5,9);
imshow(sfm4_demodulated4);
title(num2str(psnr(sfm4_demodulated4,M)));
subplot(2,5,10);
imshow(sfm5_demodulated5);
title(num2str(psnr(sfm5_demodulated5,M)));

k_f = 1e3 : 1e3 : 32e3;
