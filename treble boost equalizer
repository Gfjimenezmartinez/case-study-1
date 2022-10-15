%create treble boost using high pass 3 kHz-14 kHz

%3000 hertz high pass circuit
R=53;
C=1e-6;
tau= R*C;

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
z1=conv(High_pass,xv);z1=z1(L);%3000 hertz cut off
z2=conv(High_pass2,xv);z2=z2(L);%14000 hertz cut off
%
done=0;
coef=input('enter equalization coefficients [low, mid-low, mid-hi, hi]: ');
if isempty(coef),coef=[1 1 1 1];end

% extract the signal in each of the frequency band: 300-1400,1400
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
