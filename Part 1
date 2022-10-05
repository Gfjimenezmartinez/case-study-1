%% Introduction
% * Author:                  Lupe Jimenez
% * Class:                    ESE 351
% * Date:                     Created 
% * With contributions from: 
clc
clear all
close all

%%part 1

%plug in given values of circuit
R=1000;
C=5e-6;
tau= R*C;

fs= 44100; %frequency (standard audio sampling rate)
ts=0:1/fs:15*tau; %time sample frequency(given:15*tau)
delta_t=1/fs; %given deltaT=1/fs

%create treble boost using high pass 3 kHz-14 kHz

%high pass 
Vin_H=ones(size(ts,2),1);
a2=[1 -(1-delta_t/tau)];% coefficients of Vin terms High  pass
b2=[1 -1];%coefficients of Vout terms; High pass
High_pass = filter(b2, a2,Vin_H); % Simulate system

%low pass 
a1=[1 -(1-delta_t/tau)];% coefficients of Vin terms low pass*
b1=[delta_t/tau];%coefficients of Vout terms; low pass
Vin_L=ones(size(t,2),1);
Low_pass=filter(b1, a1, Vin_L);

%create unity using bandpass combination of low and high 230-910 Hertz and
%910 - 3 kHz

% cut off frequency of the LPF is higher than the cut off frequency of the high pass filter, 
% select range of the frequencies to pass through

%frqn_low or high= 1/2*pi*R*C
%bandwidth = frqn_high-frqn_low

%230 hertz low pass circuit
R=691978;
C=1e-9;
tau= R*C;
f=230;%hertz

%60 hertz low pass circuit
R=2652.58;
C=1e-6;
tau= R*C;
f=60;%hertz


Low_pass=filter(b1, a1, Vin_L);
High_pass = filter(b2, a2,Vin_H); % Simulate system


%create bass boost using low pass 60 hertz-230 hz

Low_pass=filter(b1, a1, Vin_L);
