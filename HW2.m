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

title('DFT of the given signal');
xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');
hold all;



%%%%%%%%%%%%%%%%%%%%

%Question 3 - EIV:



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
xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');


%Question 6:

figure(f2);
subplot(2,3,2);


lineContainsSingal = xSpectralMat(lineContainsT,:);
length(lineContainsSingal)

lineContainsSingal128 = lineContainsSingal(N/2-128/2:N/2+128/2-1);
lx6 = length(lineContainsSingal128);
x_lineContainsSingal128 = linspace(0,FS1/2,lx6/2);
x_lineContainsSingal128Fft = fft(x_lineContainsSingal128);
subplot(2,3,2);
plot(x_lineContainsSingal128, db(abs(fft(lineContainsSingal128(1:lx6/2)))));



xlabel('Frequency [HZ]');
ylabel('abs(DFT) [db]');




