clear all; close all 
clc
%% señal 
  %Fs = 512; %Hz de muestreo 
Fs = 10000;
Ts = 1/Fs; %periodo de muestreo 
  %L  = 1024; %muestras
  %t = (0:L-1).*Ts; %vector de tiempo
  %s = 2*sin(2*pi*5*t)+sin(2*pi*12.5*t)+1.5*sin(2*pi*20*t)+0.5*sin(2*pi*155*t);% señal 
s = {};% introducimos datos experimentales
s = cell2mat(s);
% s2 = mean(s);
% s= s-s2;
  %s = s';
%t = (1:length(s));
t = (0.5:0.5:length(s)/2);
L  = length(s);
plot(t,s)
title('Señal')

%% espectro de frecuencias
y = fft(s,500);
%P1 = 2.*(abs(y(1:L/2)/L));
%P1 = (abs(y(1:L/2)/L));
P1 = (abs(y(1:L/4)/L));
Area = trapz(P1);
%f = Fs.*(0:(L/2)-1)./L; %vector de frecuencia 
figure 
%plot(f,P1)
plot(P1)
title('FFT')
xlabel('Frecuencia')
ylabel('Amplitud')
%plot(abs(y))

% figure
% plot(imag(y))%graficatr parte imaginara, es la fase 
%% obtencion de la funcion 
Z=  ifft(y);
figure
plot(abs(Z))

