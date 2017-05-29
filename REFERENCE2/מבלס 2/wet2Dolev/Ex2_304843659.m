function [  ] = Ex2_304843659(  )
clear all; close all; clc;

%student: Gil Cherniak, id: 203126412
%student: Dolev Ofri, id: 304843659


%---question 1.a------------------------------------------------------

load('signal.mat');

k = (0:2047);
f = 1000*k/2048;
X_d = (20*log10(abs(fft(x))));


figure(1);
subplot(2,1,1);
plot (f(1:2048), X_d(1:2048), 'b-'); 
title('20log_1_0|X^d[k]|');
xlabel('f[Hz]');
ylabel('20log_1_0|X^d[k]| [dB]');
grid on;
hold all;

figure(4);
subplot(3,1,1);
plot (f(1:2048), X_d(1:2048), 'b-'); 
title('20log_1_0|X^d[k]|');
xlabel('f[Hz]');
ylabel('20log_1_0|X^d[k]| [dB]');
grid on;
hold all;

%---question 1.d------------------------------------------------------

N=256;
f2=linspace(0,1000,128);
X_d_window=fft_windows(x,N);
t=(0:(N/2000):(length(x)-1)/2000);

X_d_window_pos = X_d_window(: , 1:(N/2));

figure(1);
subplot(2,1,2);
mesh(f2,t,20*log10(abs(X_d_window_pos))); 
title('Spectrogram(x)');
xlabel('f[Hz]');
ylabel('t[sec]');
zlabel('20log_1_0|X^d[k]| [dB]')
grid on;
view(15,75);
hold all;

%---question 1.e------------------------------------------------------

t0=0.55;
N_w = N*floor(t0*2000/N);
x_w = x(N_w+1:N_w+N);
X_d_w = fft(x_w);
f_w = linspace(0,1000,N/2);

figure(2);
subplot(2,3,1);
plot (f_w, 20*log10(abs(X_d_w(1:N/2))), 'b-'); 
title('20log_1_0|X^d[k]|_{window with t=0.55sec}');
xlabel('f[Hz]');
ylabel('20log_1_0|X^d[k]| [dB]');
grid on;
hold all;


%---question 1.f------------------------------------------------------

x_w_h=x_w(65:192);
X_d_w_h=fft(x_w_h);
f_w_h = linspace(0,1000,N/4);

figure(2);
subplot(2,3,2);
plot (f_w_h, 20*log10(abs(X_d_w_h(1:N/4))), 'b-'); 
title('20log_1_0|X^d[k]|_{128window t=0.55sec}');
xlabel('f[Hz]');
ylabel('20log_1_0|X^d[k]| [dB]');
grid on;
hold all;


%---question 1.g------------------------------------------------------

x_w_h_p=[x_w_h zeros([1,128])];
X_d_w_h_p=fft(x_w_h_p);
f_w_h_p = linspace(0,1000,N/2);

figure(2);
subplot(2,3,3);
plot (f_w_h_p, 20*log10(abs(X_d_w_h_p(1:N/2))), 'b-'); 
title('20log_1_0|X^d[k]|_{128window padded}');
xlabel('f[Hz]');
ylabel('20log_1_0|X^d[k]| [dB]');
grid on;
hold all;

%---question 1.h.e------------------------------------------------------

figure(2);
subplot(2,3,4);
plot (f_w, 20*log10(abs(X_d_w(1:N/2))), 'b-'); 
title('20log_1_0|X^d[k]|_{window with t=0.55sec}');
xlabel('f[Hz]');
ylabel('20log_1_0|X^d[k]| [dB]');
grid on;
hold all;


%---question 1.h.f------------------------------------------------------

x_w_b=x_w(65:192).*blackman(N/2).';
X_d_w_b=fft(x_w_b);
f_w_b = linspace(0,1000,N/4);

figure(2);
subplot(2,3,5);
plot (f_w_b, 20*log10(abs(X_d_w_b(1:N/4))), 'b-'); 
title('20log_1_0|X^d[k]|_{blackman}');
xlabel('f[Hz]');
ylabel('20log_1_0|X^d[k]| [dB]');
grid on;
hold all;


%---question 1.h.g------------------------------------------------------

x_w_b_p= [x_w_b zeros([1,128])];
X_d_w_b_p=fft(x_w_b_p);
f_w_b_p = linspace(0,1000,N/2);

figure(2);
subplot(2,3,6);
plot (f_w_b_p, 20*log10(abs(X_d_w_b_p(1:N/2))), 'b-'); 
title('20log_1_0|X^d[k]|_{blackman padded}');
xlabel('f[Hz]');
ylabel('20log_1_0|X^d[k]| [dB]');
grid on;
hold all;

%---question 1.l------------------------------------------------------

h1=[1 1];

figure(3);
subplot(1,2,1);
zplane(h1);
title('filter 1_{zeros and poles}');
xlabel('Real Axis');
ylabel('Imaginary Axis');
grid on;
hold all;

h2=[1 0 0 1];

figure(3);
subplot(1,2,2);
zplane(h2);
title('filter 2_{zeros and poles}');
xlabel('Real Axis');
ylabel('Imaginary Axis');
grid on;
hold all;

%---question 1.m------------------------------------------------------

% conv_h1=conv(x,[1 1]);
% conv_h2=conv(x,h2);
% 
% Y_h1=fftshift(fft(conv_h1));
% Y_h2=fftshift(fft(conv_h2));
% 

h1_p=[1 1 zeros([1,(length(x)-2)])];
h2_p=[1 0 0 1 zeros([1,(length(x)-4)])];

H1_d=fft(h1_p);
H2_d=fft(h2_p);

Y_h1=fftshift((fft(x)).*H1_d);
Y_h2=fftshift((fft(x)).*H2_d);

f_h1=linspace(0,1000,length(Y_h1)/2);
f_h2=linspace(0,1000,length(Y_h2)/2);

figure(4);
subplot(3,1,2);
plot (f_h1, 20*log10(abs(Y_h1(((length(Y_h1)/2)+1):end))), 'b-'); 
title('20log_1_0|DFT(x*filter1)|_{filter1}');
xlabel('f[Hz]');
ylabel('20log_1_0|DFT(x*filter1)| [dB]');
grid on;
hold all;

figure(4);
subplot(3,1,3);
plot (f_h2, 20*log10(abs(Y_h2(((length(Y_h2)/2)+1):end))), 'b-'); 
title('20log_1_0|DFT(x*filter2)|_{filter2}');
xlabel('f[Hz]');
ylabel('20log_1_0|DFT(x*filter2)| [dB]');
grid on;
hold all;


end

