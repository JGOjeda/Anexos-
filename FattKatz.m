t= [0:0.2:1.4];
T= 0.221;
P= 1-exp(-t/T);
plot(t,P)

dt=0.2;
N= [0:5:60];
n= (N.*dt)/T.*exp(-t./T)
figure
plot(n)