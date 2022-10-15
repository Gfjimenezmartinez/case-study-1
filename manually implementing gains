
% extract the signal in each of the frequency band: 0~60, 60~230,
% multiply each with the corresponding equalizer coeffs
% entered and add up the scaled signal
%
yx=[(5.*z1) (2.*z2-z1) (2.*z3-z2) z4-z3 z5-z4 z6-z5 xv-z6];
fx=abs(fft(yx));fx=fx(1:ly/2)/xvfs;
figure
loglog(w, fy, w,fx,'--');
legend('orignal','equalized signal')
xlabel('f (Hz)');
ylabel('|Y(f)|');
disp('original')
sound(xv,xvfs)
pause(5)
