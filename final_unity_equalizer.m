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


%910 hertz

R= 174.8955;
C=1e-6;
tau= R*C;

fs= 44100; %frequency (standard audio sampling rate)
ts=0:1/fs:15*tau; %time sample frequency(given:15*tau)
delta_t=1/fs; %given deltaT=1/fs
Signal_in=xv;

Signal_in=xv;

fs= 44100;%frequency (standard audio sampling rate)
ts=0:1/fs:15*tau; %time sample frequency(given:15*tau)
delta_t=1/fs; %given deltaT=1/fs

%high pass 
a2=[1 -(1-delta_t/tau)];% coefficients of Vin terms High  pass
b2=[1 -1];%coefficients of Vout terms; High pass
High_pass = filter(b2, a2,Signal_in); % Simulate system

%230 hertz
R= 691.9780;
C=1e-6;
tau= R*C;

%low pass 
a1=[1 -(1-delta_t/tau)];% coefficients of Vin terms low pass*
b1=[delta_t/tau];%coefficients of Vout terms; low pass
Bandpass1=filter(b1, a1, High_pass);

%2nd bandpass
%3000 hertz
R=53.0516;
C=1e-6;
tau= R*C;

%high pass 
a2=[1 -(1-delta_t/tau)];% coefficients of Vin terms High  pass
b2=[1 -1];%coefficients of Vout terms; High pass
High_pass2 = filter(b2, a2,Signal_in); % Simulate system

%910 hertz

R= 174.8955;
C=1e-6;
tau= R*C;

%low pass 
a1=[1 -(1-delta_t/tau)];% coefficients of Vin terms low pass*
b1=[delta_t/tau];%coefficients of Vout terms; low pass
Bandpass2=filter(b1, a1, High_pass2);



%for vector to have the same legnth
L=500:499+ly;
% cutoff freq =
z5=conv(Bandpass1,xv);z5=z5(L);%3000 hertz cut off
z6=conv(Bandpass2,xv);z6=z6(L);%14000 hertz cut off
%
coef=[1 500 1];

% extract the signal in each of the frequency band: 230-910,910-3000,
% multiply each with the corresponding equalizer coeffs
% entered and add up the scaled signal
%
yx=[z5 z6-z5 xv-z6]*coef';

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


