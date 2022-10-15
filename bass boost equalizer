
clc
clear all
close all

% Case Study 1 - Demo

% load noisy audio data, then play recording
[xv,xvfs] = audioread('BeyondTheSea.wav'); 
xv=xv(:,1);
% no of points in the data
ly=length(xv);
ty=([1:ly]'-1)/xvfs;
w=([1:ly]'-1)/ly*xvfs;
w=w(1:ly/2);

%in Hz, single-sided spectrum
fxv=abs(fft(xv));
fy=fxv(1:ly/2)/xvfs;
% show time-domain waveform
t = [0:length(xv)-1]*1/xvfs; 

%230 hertz low pass circuit
R=70000;
C=1e-9;
tau= R*C;


fs= 44100; %frequency (standard audio sampling rate)
ts=0:1/fs:15*tau; %time sample frequency(given:15*tau)
delta_t=1/fs; %given deltaT=1/fs

Signal_in=xv;

%low pass 
a1=[1 -(1-delta_t/tau)];% coefficients of Vin terms low pass*
b1=[delta_t/tau];%coefficients of Vout terms; low pass
Low_pass=filter(b1, a1, Signal_in);

%60 hertz low pass circuit
R=2652.58;
C=1e-6;
tau= R*C;
%2nd low pass
Low_pass2=filter(b1, a1, Signal_in);

%for vector to have the same legnth
L=500:499+ly;
% cutoff freq =
z1=conv(Low_pass,xv);z1=z1(L);%230 hertz cut-off
z2=conv(Low_pass2,xv);z2=z2(L);%60 hertz low pass circuit
%
done=0;
coef=input('enter equalization coefficients [low, mid-low, mid-hi, hi]: ');
if isempty(coef),coef=[1 1 1];end

% extract the signal in each of the frequency band: 0~60, 60~230,
% multiply each with the corresponding equalizer coeffs
% entered and add up the scaled signal
%
yx=[z1 z2-z1 xv-z2]*coef';
fx=abs(fft(yx));fx=fx(1:ly/2)/xvfs;
figure
loglog(w, fy, w,fx,'--');
legend('orignal','equalized signal')
xlabel('f (Hz)');
ylabel('|Y(f)|');
disp('original')
sound(xv,xvfs)
pause(5)
