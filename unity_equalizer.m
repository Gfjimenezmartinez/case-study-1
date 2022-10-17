
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

%910 hertz

R= 174.8955;
C=1e-6;
tau= R*C;

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
z1=conv(Bandpass1,xv);z1=z1(L);%3000 hertz cut off
z2=conv(Bandpass2,xv);z2=z2(L);%14000 hertz cut off
%
done=0;
coef=input('enter equalization coefficients [low, mid-low, mid-hi, hi]: ');
if isempty(coef),coef=[1 1 1 1];end

% extract the signal in each of the frequency band: 230-910,910-3000,
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


