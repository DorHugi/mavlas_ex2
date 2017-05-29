%Question 1:


clear all; close all ; clc;
load('signal.mat');
f1 = figure();
f2 = figure();



figure(f1);
subplot(2,1,1);
dft1 = abs(fft(x));
FS1 = 2*1000;
Lx1 = length(x);
x1 = linspace(0,FS1,Lx1);

plot(x1(1:Lx1/2),mag2db(dft1(1:Lx1/2)));

figure(4)
subplot(3,1,1)
plot(x1(1:Lx1/2),mag2db(dft1(1:Lx1/2)));
title('DFT of the given signal');
xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');
grid on;
hold all;

title('DFT of the given signal');
xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');
hold all;



%Question 4:
figure(f1);

subplot(2,1,2);

N = 256;
xSpectralMat = fft_windows(x,N);

%Each row i of xSpecMat represents time that ranges from
%[(i-1)*N/Fs,i*N/Fs]

%Generate time axis:

t = (0: N/FS1:(length(x)-1)/FS1);
xSpectralMatdb = db(abs(xSpectralMat(:,1:N/2))); %mat to db(abs).
w3d = linspace(0,FS1/2,N/2);
mesh(w3d,t,xSpectralMatdb)
view(15,75);
title('Spectral analysis of the given signal');
xlabel('Frequncy [Hz]');
ylabel('Time [sec]');
zlabel('DFT [db]');


%Question 5:

%According to the formula we've described above, the line that contains
%time t is floor(t*Fs/N), and it can be derived by comparing the two
%sections of the equations, and using the value of t. Since the first
%matrix line has on offset of 1, we have to add this offset. hence - in our
%case, the line is : floor(0.55*Fs/N) +1 

lineContainsT =  floor(0.55*FS1/N) +1 ;
figure(f2);

subplot(2,3,1);
plot(w3d,xSpectralMatdb(lineContainsT,:))
title('DFT t=0.55 interval');
xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');


%Question 6:

figure(f2);
subplot(2,3,2);


lineContainsSingal = x(1+(lineContainsT-1)*N:1+(lineContainsT-1)*N + N);


lineContainsSingal128 = lineContainsSingal(N/2-128/2+1:N/2+128/2);

lx6 = length(lineContainsSingal128);
x_lineContainsSingal128 = linspace(0,FS1/2,lx6/2);

x_lineContainsSingal128DbAbsFft = db(abs(fft(lineContainsSingal128)));
subplot(2,3,2);
plot(x_lineContainsSingal128, x_lineContainsSingal128DbAbsFft(1:lx6/2));

xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');
title('Truncated signal');


%Question 7:
q7sig = [lineContainsSingal128, zeros(1,128)];
lx7 = length(q7sig);
xAxis7 = linspace(0,FS1/2,lx7/2);
q7sigDbAbsFft = db(abs(fft(q7sig)));
subplot(2,3,3);
plot(xAxis7, q7sigDbAbsFft(1:lx7/2));

xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');
title('zero padded signal');

%Question 8.5
lineContainsT =  floor(0.55*FS1/N) +1 ;
figure(f2);

subplot(2,3,4);
plot(w3d,xSpectralMatdb(lineContainsT,:))
title('DFT t=0.55 interval');
xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');

%Question 8.6

figure(f2);
subplot(2,3,2);


lineContainsSingal128_blackman = lineContainsSingal(N/2-128/2+1:N/2+128/2).*blackman(N/2).';

x_lineContainsSingal128 = linspace(0,FS1/2,lx6/2);

lineContainsSingal128DbAbsFft_blackman = db(abs(fft(lineContainsSingal128_blackman)));
subplot(2,3,5);

plot(x_lineContainsSingal128, lineContainsSingal128DbAbsFft_blackman(1:lx6/2));

xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');
title('Truncated* blackman');




%Question 8.7
q7sig = [lineContainsSingal128, zeros(1,128)].*blackman(256).';
lx7 = length(q7sig);
xAxis7 = linspace(0,FS1/2,lx7/2);
q7sigDbAbsFft = db(abs(fft(q7sig)));
subplot(2,3,6);
plot(xAxis7, q7sigDbAbsFft(1:lx7/2));

xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');
title('padded * blackman');





%Question 12
fil1=[1 1];
fil2=[1 0 0 1];

figure(3);
subplot(1,2,1);
zplane(fil1);
title('filter 1');
xlabel('Re');
ylabel('Img');
grid on;
hold all;


subplot(1,2,2);
zplane(fil2);
title('filter 2');
xlabel('Re');
ylabel('Img');
grid on;
hold off;

%Question 12
fil_1_extended=[1 1 , zeros([1,(length(x)-2)])];
fil2_extended=[1 0 0 1 , zeros([1,(length(x)-4)])];
fil1_dft=abs(fft(fil_1_extended));
fil2_dft=abs(fft(fil2_extended));
sig1_full = fil1_dft.*(abs(fft(x)));
sig2_full = fil2_dft.*(abs(fft(x)));

figure(4);
subplot(3,1,2)
plot(x1(1:Lx1/2),mag2db(sig1_full(1:Lx1/2)));
title('DFT of the given signal');
xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');
grid on;
hold all;

figure(4);
subplot(3,1,3)
plot(x1(1:Lx1/2),mag2db(sig2_full(1:Lx1/2)));
title('DFT of the given signal');
xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');
grid on;
hold off;
