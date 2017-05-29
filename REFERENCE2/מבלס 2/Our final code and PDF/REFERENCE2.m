%student: Eyal Habif, ID: 303163331
%student: Naama Pearl, ID: 203370085

clc
clear all
close all
%---------------------------------------------------------------------------
%Q-A 

load signal.mat
Fs=2000;
f1=linspace(0,1000,length(x)/2);
signal_dft=fft(x);

figure(1);
subplot(2,1,1)
plot(f1,db(abs(signal_dft(1:length(signal_dft)/2))))
title('DFT of signal');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;


figure(4);
subplot(3,1,1)
plot(f1,db(abs(signal_dft(1:length(signal_dft)/2))))
title('DFT of signal');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;


%---------------------------------------------------------------------------
%Q-D 

signal_dft_window = fft_windows(x,256);
t=(0:256/2000:(length(x)-1)/Fs);
f2=linspace(0,1000,128);

signal_dft_window_new = signal_dft_window(:,1:(128));

figure(1);
subplot(2,1,2)
mesh(f2,t,db(abs(signal_dft_window_new)))
title('Spectogram of x[n]');
xlabel('Frequency [Hz]');
ylabel('Time [sec]');
zlabel('DFT signal [db]');
view(15,75);
hold all;

%---------------------------------------------------------------------------
%Q-E1

k=ceil(0.55*2000/256);

figure(2);
subplot(2,3,1)
plot(f2,db(abs(signal_dft_window_new(k,:))))
title('DFT of t=0.55');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;

%---------------------------------------------------------------------------
%Q-F1

x_mat1=vec2mat(x,256);
signal_128=x_mat1(k,65:192);
signal_128_dft=fft(signal_128);
f3=linspace(0,1000,64);

figure(2);
subplot(2,3,2)
plot(f3,db(abs(signal_128_dft(1:end/2))))
title('DFT cut signal');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;

%---------------------------------------------------------------------------
%Q-G1

signal_256 = [zeros(1,64),signal_128,zeros(1,64)];
signal_256_dft=fft(signal_256);

figure(2);
subplot(2,3,3)
plot(f2,db(abs(signal_256_dft(1:end/2))))
title('DFT cut signal zeros');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;

%---------------------------------------------------------------------------
%Q-E2

k=ceil(0.55*2000/256);

figure(2);
subplot(2,3,4)
plot(f2,db(abs(signal_dft_window_new(k,:))))
title('DFT of t=0.55');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;

%---------------------------------------------------------------------------
%Q-F2

x_mat2=vec2mat(x,256);
signal_128_blackman=x_mat2(k,65:192).*blackman(128).';
signal_128_blackman_dft=fft(signal_128_blackman);


figure(2);
subplot(2,3,5)
plot(f3,db(abs(signal_128_blackman_dft(1:end/2))))
title('DFT cut signal - blackman');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;


%---------------------------------------------------------------------------
%Q-G2

signal_256_blackman = [zeros(1,64),signal_128_blackman,zeros(1,64)];
signal_256_blackman_dft=fft(signal_256_blackman);

figure(2);
subplot(2,3,6)
plot(f2,db(abs(signal_256_blackman_dft(1:end/2))))
title('DFT cut signal zeros - blackman');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;

%---------------------------------------------------------------------------
%Q-H

filter_1=[1 1];

figure(3);
subplot(1,2,1);
zplane(filter_1);
title('filter 1 zeros and poles');
xlabel('Real Axis');
ylabel('Imaginary Axis');
grid on;
hold all;

filter_2=[1 0 0 1];

figure(3);
subplot(1,2,2);
zplane(filter_2);
title('filter 2 zeros and poles');
xlabel('Real Axis');
ylabel('Imaginary Axis');
grid on;
hold all;

%---------------------------------------------------------------------------
%Q-J

filter_1_whole=[1 1 , zeros([1,(length(x)-2)])];
filter_2_whole=[1 0 0 1 , zeros([1,(length(x)-4)])];

filter_1_whole_dft=fft(filter_1_whole);
filter_2_whole_dft=fft(filter_2_whole);

signal_filter_1 = filter_1_whole_dft.*(fft(x));
signal_filter_2 = filter_2_whole_dft.*(fft(x));

figure(4);
subplot(3,1,2)
plot(f1,db(abs(signal_filter_1(1:length(signal_filter_1)/2))))
title('DFT of signal');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;

figure(4);
subplot(3,1,3)
plot(f1,db(abs(signal_filter_2(1:length(signal_filter_2)/2))))
title('DFT of signal');
xlabel('Frequency [Hz]');
ylabel('DFT [db]');
grid on;
hold all;
