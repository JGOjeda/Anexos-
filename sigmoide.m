%clear all; clc, cla
x= [-60:60];
y= 1./(60*(0.04+exp(-x)));
%figure 1
plot(x,y)

dy= diff(y);
%figure 2
hold on
plot(x(2:121),dy)