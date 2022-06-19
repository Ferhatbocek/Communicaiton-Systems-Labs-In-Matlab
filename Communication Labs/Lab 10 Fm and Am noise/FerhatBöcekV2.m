clc;
close all;
im = imread('cameraman.tif');
im1 = im2double(im);
l=numel(im1);

fs = l;
Ts = 1/fs;
f = linspace(-fs/2,fs/2,l);
shaped = reshape(im1,1,[]);

Mt = abs(fft(shaped,l))./l;
Mt = fftshift(Mt);
figure(1);
plot(f,Mt);
grid on;
xlabel("frequency (Hz)");
ylabel("Magnitude of |M(f)|");

kf=27000;
f_cdsb = 16000;
t = 0:Ts:1-Ts;
ct = cos(2*pi*f_cdsb*t);
ut=ct.*shaped;
fmsig = cos(2*pi*4000*t + kf*2*pi*(cumsum(shaped)*Ts));

snr = [0 5 10 20 30];

st1 = awgn(ut,snr(1),'measured');
st2 = awgn(ut,snr(2),'measured');
st3 = awgn(ut,snr(3),'measured');
st4 = awgn(ut,snr(4),'measured');
st5 = awgn(ut,snr(5),'measured');

ft1 = awgn(fmsig,snr(1),'measured');
ft2 = awgn(fmsig,snr(2),'measured');
ft3 = awgn(fmsig,snr(3),'measured');
ft4 = awgn(fmsig,snr(4),'measured');
ft5 = awgn(fmsig,snr(5),'measured');

%10.3 demod 

vt1 =  2*st1 .* ct;
vt2 =  2*st2 .* ct;
vt3 =  2*st3 .* ct;
vt4 =  2*st4 .* ct;
vt5 =  2*st5 .* ct;

fdemod1 = fmdemod(ft1,4000,fs,kf);
fdemod2 = fmdemod(ft2,4000,fs,kf);
fdemod3 = fmdemod(ft3,4000,fs,kf);
fdemod4 = fmdemod(ft4,4000,fs,kf);
fdemod5 = fmdemod(ft5,4000,fs,kf);

[b,a] = butter(2,9500/(fs/2),"low");
m_demod1 = filter(b,a,vt1);
m_demod2 = filter(b,a,vt2);
m_demod3 = filter(b,a,vt3);
m_demod4 = filter(b,a,vt4);
m_demod5 = filter(b,a,vt5);

MrDSB10 = abs(fft(m_demod3,l));
MrDSB10 = fftshift(MrDSB10)./l;

Ffm10 = abs(fft(fdemod3,l))./l;
Ffm10 = fftshift(Ffm10);

figure(2)
subplot(2,1,1);
plot(f,MrDSB10);
xlabel("frequency (Hz)");
ylabel("r_D_S_B_1_0(f)");
grid on;
subplot(2,1,2);
plot(f,Ffm10);
xlabel("frequency (Hz)");
ylabel("r_f_m_1_0(f)");
grid on;
 
ln = 256;

m_demod1 = reshape(m_demod1,[ln,ln]);
m_demod2 = reshape(m_demod2,[ln,ln]);
m_demod3 = reshape(m_demod3,[ln,ln]);
m_demod4 = reshape(m_demod4,[ln,ln]);
m_demod5 = reshape(m_demod5,[ln,ln]);

fdemod1 = reshape(fdemod1,[ln,ln]);
fdemod2 = reshape(fdemod2,[ln,ln]);
fdemod3 = reshape(fdemod3,[ln,ln]);
fdemod4 = reshape(fdemod4,[ln,ln]);
fdemod5 = reshape(fdemod5,[ln,ln]);

figure(3) 
subplot(2,5,1);
imshow(m_demod1); title("SNR = " + num2str(psnr(m_demod1,im1)));
subplot(2,5,2);
imshow(m_demod2); title("SNR = " + num2str(psnr(m_demod2,im1)));
subplot(2,5,3);
imshow(m_demod3); title("SNR = " + num2str(psnr(m_demod3,im1)));
subplot(2,5,4);
imshow(m_demod4); title("SNR = " + num2str(psnr(m_demod4,im1)));
subplot(2,5,5);
imshow(m_demod5); title("SNR = " + num2str(psnr(m_demod5,im1)));

subplot(2,5,6);
imshow(fdemod1); title("SNR = " + num2str(psnr(fdemod1,im1)));
subplot(2,5,7);
imshow(fdemod2); title("SNR = " + num2str(psnr(fdemod2,im1)));
subplot(2,5,8);
imshow(fdemod3); title("SNR = " + num2str(psnr(fdemod3,im1)));
subplot(2,5,9);
imshow(fdemod4); title("SNR = " + num2str(psnr(fdemod4,im1)));
subplot(2,5,10);
imshow(fdemod5); title("SNR = " + num2str(psnr(fdemod5,im1)));

%10.4 b

f_cdsb1 = 32500;
ct1 = cos(2*pi*f_cdsb1*t);
ut1=ct1.*shaped;
st6 = awgn(ut1,snr(5),'measured');
vt6 =  2*st6.*ct1;
m_demod6 = filter(b,a,vt6);
m_demod6 = reshape(m_demod6,[ln,ln]);
figure(4)
imshow(m_demod6); title("SNR = " + num2str(psnr(m_demod6,im1)));

%10.4 c;
shaped2 = upsample(shaped,2);
fs2 = 2*fs;
t1 = 0:1/fs2:1-(1/fs2);
ct2 = cos(2*pi*f_cdsb1*t1);
ut2=ct2.*shaped2;
st7 = awgn(ut2,snr(5),'measured');
vt7 =  2*st7.*ct2;
m_demod7 = filter(b,a,vt7);
m_demod7 = downsample(m_demod7,2);
m_demod7 = reshape(m_demod7,[256,256]);
figure(5)
imshow(m_demod7); title("SNR = " + num2str(psnr(m_demod7,im1)));

