%script para modelar el estimulo con corriente sinuoidal con alta
%frecuencia ruidosa
% por ley de Ohm 
%V=IR
% clear all; clc; close all
% I= 600e-6;
% R= 7.1e3;
% V= I*R;
% S= 1:(5*60); %tiempo de estimulacion en seguntos 
% 
% %S2= length(S);%longitud de S
% %% Corriente directa
% ID(1:length(S)) =  I; %Estimulacion con corriente directa 
% V= R.*ID;
% plot(S,V)

%% funcion seno corriente altena 
t = [0:0.01:1];%length(S)]; %vector de tiempo 
A = 10 ;%amplitud 
pha = 0; %fase
f = [101:600];%6; %frecuencia 
T = 1./f; %periodo
Fs=f;
x = A*sin(2.*pi.*f.*t+pha);
y = ((3/4)*x)+x.^2;
%graficas
subplot(2,2,1)
plot(t,x,'b')
% 
subplot(2,2,2)
plot(t,y,'r')
%hold on 
plot(t,y)
grid on 
% 
% %funcion 1 dominio de la frecuencia 
% L = length(x); %dimension de la frecuencia x
% nFFT=2; %contador para la transformada rapida da fourier 
% while nFFT<L
%     nFFT=nFFT*32;
% end   
% Y1=fft(x,nFFT); %funcion de la transformada de fourier
% PS1 =  abs(Y1); %Periodograma simple
% f=linspace(0,Fs,nFFT);
% subplot(2,2,3)
% 
% 
% 
% 
% 





%% funcion para corriente HF 
%IA= S.*sin (60);
%plot(S,IA)
%IHF=