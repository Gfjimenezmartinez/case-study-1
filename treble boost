
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
High_pass2 = filter(b2, a2,High_pass); % Simulate system


figure(); 
subplot(2,1,1)
plot(t,xv), title("original")
xlabel('t, seconds')
ylabel('amplitude')
subplot(2,1,2)
plot(t,High_pass2), title("filter:Simulation High Pass")
xlabel('t, seconds')
ylabel('amplitude')
%sound(High_pass,xvfs)

% show transform
figure()
f = [0:length(High_pass2)-1]*xvfs/length(High_pass2);
XV = fft(High_pass2); 
 plot(f,abs(XV));
xlabel('f, Hz')
ylabel('|X(f)|')



