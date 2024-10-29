N=2048;

dt=0.001;
Fs=1./dt;
time=dt*[-N/2:N/2-1];

freq=20.;
y=cos(2*pi*freq*time);

yshft=circshift(y,[0,N/2]);

ffty=fft(yshft,N)/N;

Y=circshift(ffty,[0,N/2]);

df=Fs/N;
Fvec=df*[-N/2:N/2-1];

plot(Fvec)