%create unity using bandpass combination of low and high 230-910 Hertz
%230 hertz low pass circuit
R=70000;
C=1e-9;
tau= R*C;

fs= 44100; %frequency (standard audio sampling rate)
ts=0:1/fs:15*tau; %time sample frequency(given:15*tau)
delta_t=1/fs; %given deltaT=1/fs

Signal_in=xv;

%high pass 
a2=[1 -(1-delta_t/tau)];% coefficients of Vin terms High  pass
b2=[1 -1];%coefficients of Vout terms; High pass
High_pass = filter(b2, a2,Signal_in); % Simulate system

%lowpass

%plug in given values of circuit
R=175;
C=1e-6;
tau= R*C;
%low pass 
a1=[1 -(1-delta_t/tau)];% coefficients of Vin terms low pass*
b1=[delta_t/tau];%coefficients of Vout terms; low pass
Low_pass=filter(b1, a1, High_pass);

figure(); 
subplot(3,1,1)
plot(t,xv), title("original")
xlabel('t, seconds')
ylabel('amplitude')
subplot(3,1,2)
plot(t,High_pass), title("filter:high Pass")
xlabel('t, seconds')
ylabel('amplitude')
subplot(3,1,3)
plot(t,Low_pass), title("filter: low pass")
xlabel('t, seconds')
ylabel('amplitude')

%sound(Lowpass_1,xvfs)
figure()
% show transform
subplot(2,1,1)
f = [0:length(High_pass)-1]*xvfs/length(High_pass);
XV = fft(High_pass); 
 plot(f,abs(XV));
xlabel('f, Hz')
ylabel('|X(f)|')
subplot(2,1,2)
f = [0:length(Low_pass)-1]*xvfs/length(Low_pass);
XV = fft(Low_pass); 
 plot(f,abs(XV));
xlabel('f, Hz')
ylabel('|X(f)|')

%create unity using bandpass combination  910- 3000 hz
%3000 hertz low pass circuit
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

%plug in given values of circuit
R=175;
C=1e-6;
tau= R*C;
%low pass 
a1=[1 -(1-delta_t/tau)];% coefficients of Vin terms low pass*
b1=[delta_t/tau];%coefficients of Vout terms; low pass
Low_pass=filter(b1, a1, High_pass);

figure(); 
subplot(3,1,1)
plot(t,xv), title("original")
xlabel('t, seconds')
ylabel('amplitude')
subplot(3,1,2)
plot(t,High_pass), title("filter:high Pass")
xlabel('t, seconds')
ylabel('amplitude')
subplot(3,1,3)
plot(t,Low_pass), title("filter: low pass")
xlabel('t, seconds')
ylabel('amplitude')

%sound(Lowpass_1,xvfs)
figure()
% show transform
subplot(2,1,1)
f = [0:length(High_pass)-1]*xvfs/length(High_pass);
XV = fft(High_pass); 
 plot(f,abs(XV));
xlabel('f, Hz')
ylabel('|X(f)|')
subplot(2,1,2)
f = [0:length(Low_pass)-1]*xvfs/length(Low_pass);
XV = fft(Low_pass); 
 plot(f,abs(XV));
xlabel('f, Hz')
ylabel('|X(f)|')

