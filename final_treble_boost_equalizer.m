clc
clear all
close all

% Case Study 1 - Demo

% load noisy audio data, then play recording
[xv,xvfs] = audioread('BeyondTheSea.wav'); 
xv=xv(:,1);
% no of points in the data
ly=length(xv);
%in Hz, single-sided spectrum
fxv=abs(fft(xv));
fy=fxv(1:ly/2)/xvfs;
% show time-domain waveform
t = [0:length(xv)-1]*1/xvfs; 

%3000 hertz high pass circuit
R=53;
C=1e-6;
tau= R*C;

fs= 44100; %frequency (standard audio sampling rate)
ts=0:1/fs:15*tau; %time sample frequency(given:15*tau)
delta_t=1/fs; %given deltaT=1/fs

Signal_in=xv;

%high pass 
a2=[1 -(1-delta_t/tau)];% coefficients of Vin terms High  pass
b2=[1 -1];%coefficients of Vout terms; High pass
High_pass = filter(b2, a2,Signal_in); % Simulate system

%14000 hertz high pass circuit
R=11.4;
C=1e-6;
tau= R*C;

%high pass 
a2=[1 -(1-delta_t/tau)];% coefficients of Vin terms High  pass
b2=[1 -1];%coefficients of Vout terms; High pass
High_pass2 = filter(b2, a2,Signal_in); % Simulate system

%for vector to have the same legnth
L=500:499+ly;
% cutoff freq =
z3=conv(High_pass,xv);z3=z3(L);%3000 hertz cut off
z4=conv(High_pass2,xv);z4=z4(L);%14000 hertz cut off
%
% extract the signal in each of the frequency band: 300-1400,1400
% multiply each with the corresponding equalizer coeffs
% entered and add up the scaled signal
%
coef=[1 100 1];
yx=[z3 z4-z3 xv-z3]*coef';
%
figure(); 
subplot(2,1,1)
plot(t,xv), title("original")
xlabel('t, seconds')
ylabel('amplitude')
subplot(2,1,2)
plot(t,yx),title(" filter pass")
xlabel('t, seconds')
ylabel('amplitude')

%sound(High_pass,xvfs)
% show transform 
figure()
subplot(2,1,1)
f = [0:length(xv)-1]*xvfs/length(xv);
XV = fft(xv); 
 plot(f,abs(XV));title("original")
xlabel('f, Hz')
ylabel('|X(f)|')
subplot(2,1,2)
f = [0:length(yx)-1]*xvfs/length(yx);
XV = fft(yx); 
 plot(f,abs(XV));title(" filter pass")
xlabel('f, Hz')
ylabel('|X(f)|')
%
sound(yx,xvfs)
% stereoSound = yx(:, 1:2); % Extract first two channels and ignore remaining 499 channels.
% soundsc(stereoSound,xvfs);pause(5)
