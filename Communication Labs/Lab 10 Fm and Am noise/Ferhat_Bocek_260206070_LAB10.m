clc 
clear;
clearvars;

img = imread('cameraman.tif');
M = im2double(img);
d = numel(M);

fs = d; Ts = 1/d;
f = linspace(-d/2, d/2, d);
y = reshape(M,1,[]);

%% Modulation Part 

Mt = abs(fft(y,d))./d;
Mt = fftshift(Mt);
plot(f,Mt);
grid on;
xlabel("frequency (Hz)");
ylabel("Magnitude of |M(f)|");


kf=27000;
fcdsb = 16000;
t = 0: Ts : 1-Ts;
ct = cos(2*pi*fcdsb*t);
x_dsbsc = ct.*y;
Fmint = cos(2*pi*4000*t + kf*2*pi*(cumsum(y)*Ts));
snr = [0 5 10 20 30];


st1 = awgn(x_dsbsc,snr(1),'measured');
st2 = awgn(x_dsbsc,snr(2),'measured');
st3 = awgn(x_dsbsc,snr(3),'measured');
st4 = awgn(x_dsbsc,snr(4),'measured');
st5 = awgn(x_dsbsc,snr(5),'measured');

ft1 = awgn(Fmint,snr(1),'measured');
ft2 = awgn(Fmint,snr(2),'measured');
ft3 = awgn(Fmint,snr(3),'measured');
ft4 = awgn(Fmint,snr(4),'measured');
ft5 = awgn(Fmint,snr(5),'measured');

%% Demodulation

ac = 2;
vt1 = ac * st1 .* ct;
vt2 = ac * st2 .* ct;
vt3 = ac * st3 .* ct;
vt4 = ac * st4 .* ct;
vt5 = ac * st5 .* ct;

fdmd1 = fmdemod(ft1,4000,fs,kf);
fdmd2 = fmdemod(ft2,4000,fs,kf);
fdmd3 = fmdemod(ft3,4000,fs,kf);
fdmd4 = fmdemod(ft4,4000,fs,kf);
fdmd5 = fmdemod(ft5,4000,fs,kf);



[b,a] = butter(4,15000/(fs/2),"low");
mdmd1 = filter(b,a,vt1);
mdmd2 = filter(b,a,vt2);
mdmd3 = filter(b,a,vt3);
mdmd4 = filter(b,a,vt4);
mdmd5 = filter(b,a,vt5);

MDSB10 = abs(fft(mdmd3,d));
MDSB10 = fftshift(MDSB10)./d;

Fm10 = abs(fft(fdmd3,d))./d;
Fm10 = fftshift(Fm10);


figure
subplot(2,1,1);
plot(f,MDSB10);
xlabel("frequency (Hz)");
ylabel("rdsb10(f)");
grid on;
subplot(2,1,2);
plot(f,Fm10);
xlabel("frequency (Hz)");
ylabel("rfm10(f)");
grid on;

px = 256;

mdmd1 = reshape(mdmd1,[px,px]);
mdmd2 = reshape(mdmd2,[px,px]);
mdmd3 = reshape(mdmd3,[px,px]);
mdmd4 = reshape(mdmd4,[px,px]);
mdmd5 = reshape(mdmd5,[px,px]);

fdmd1 = reshape(fdmd1,[px,px]);
fdmd2 = reshape(fdmd2,[px,px]);
fdmd3 = reshape(fdmd3,[px,px]);
fdmd4 = reshape(fdmd4,[px,px]);
fdmd5 = reshape(fdmd5,[px,px]);

figure 
subplot(2,5,1); imshow(mdmd1); title('SNR = 0');
subplot(2,5,2); imshow(mdmd2); title('SNR = 5');
subplot(2,5,3); imshow(mdmd3); title('SNR = 10');
subplot(2,5,4); imshow(mdmd4); title('SNR = 20');
subplot(2,5,5); imshow(mdmd5); title('SNR = 30');

subplot(2,5,6); imshow(fdmd1); title('SNR = 0');
subplot(2,5,7); imshow(fdmd2); title('SNR = 5');
subplot(2,5,8); imshow(fdmd3); title('SNR = 10');
subplot(2,5,9); imshow(fdmd4); title('SNR = 20');
subplot(2,5,10); imshow(fdmd5); title('SNR = 30');





