%create bass boost using low pass 60 hertz-230 hz

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
Low_pass2=filter(b1, a1, Low_pass);

figure(); 
subplot(2,1,1)
plot(t,xv), title("original")
xlabel('t, seconds')
ylabel('amplitude')
subplot(2,1,2)
plot(t,Low_pass2),title(" filter pass")
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
f = [0:length(Low_pass2)-1]*xvfs/length(Low_pass2);
XV = fft(Low_pass2); 
 plot(f,abs(XV));title(" filter pass")
xlabel('f, Hz')
ylabel('|X(f)|')
