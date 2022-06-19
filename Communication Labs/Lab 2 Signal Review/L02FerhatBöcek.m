clc;
Fs=3000;
N=512;
t1 = 0:1/Fs:0.6;
n = 0:1:1800;
xn = cos(2*pi*(200/Fs)*n) + sin(2*pi*(500/Fs)*n);
%plot(t1,xn);
%grid on;

f=linspace(-Fs/2,Fs/2,N);


Xf = abs(fft(xn,N));
Xf = Xf/512; %normalization
Xf_shifted = fftshift(Xf); % hem ekside hem artıda frekans komponentlerini gösterir.


plot(f,Xf_shifted);
grid on;
xlabel("frequency (Hz)");
ylabel("|X(f)|");

%2.2
Fs2 = 5000;
t2 = 0:1/Fs2:0.3;
n2 = 0:1:1500;

xn2 = sin(2*pi*(500/Fs2)*n2) + 0.5*cos(2*pi*(1400/Fs2)*n2);
f2 = linspace(-Fs2/2,Fs2/2,1024);

%[bp ap] = butter(6,[300])
[bp,ap] = butter(7,[(300)/(Fs2/2) (700)/(Fs2/2) ],'bandpass'); % (fc / (Fs/2))
[bh,ah] = butter(7,1000/(Fs2/2),"high");


h1 = freqz(bp,ap,Fs2/2); %filtrelerin magnitude response unu bastırma
h2 = freqz(bh,ah,Fs2/2);

figure(2)
plot(abs(h1));
hold on;
plot(abs(h2));
xlabel("frequency (Hz)");
ylabel("Magnitude of the filter");
legend("Bandpass","High-Pass");
grid on;


bandpass = filtfilt(bp,ap,xn2);
bandPass = fft(bandpass,1024);
bandPass = bandPass/1024;
bandPass = abs(fftshift(bandPass));

highpass = filtfilt(bh,ah,xn2);
highPass = fft(highpass,1024);
highPass = highPass/1024;
highPass = abs(fftshift(highPass));
figure(3);
plot(f2,bandPass,LineWidth=1);
hold on;
plot(f2,highPass,LineWidth=1);
grid on;
xlabel("frequency (Hz)");
ylabel("Magnitude response after filtering");
grid on;
legend("bandpass filter","Highpass filter");

