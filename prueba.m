clear all; clc; close all
%% parametros del rudio 
t = [0:0.01:5];%length(S)]; %vector de tiempo 
A = 300 ;%amplitud 
pha = 0; %fase
f = (101:640); %frecuencia 
l = length(t);
f2= datasample(f,l); %frecuencia para aplicar 
T = 1./f; %periodo

%% rudio 
% for 
%N= A.*sin(2.*pi.*f.*t+pha);
N= A.*sin(2.*pi.*f2.*t+pha);
y= fft(N);
P2 = abs(y/l);
P1 = P2(1:l/2+1);
P1(2:end-1)=2*P1(2:end-1);

%plot (f,P1)
%h= histogram(N);
% end 
%
plot(t,N)
%plot(h)