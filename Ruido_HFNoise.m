%% programa para generar el ruido de estimulacion electrica

%script para modelar el estimulo con corriente sinuoidal con alta frecuencia ruidosa
% por ley de Ohm      V=IR
clear all; clc; close all
%% ejemplo de funcion seno 
% y = ASin(bx+c)+d
%A=amplitud  T(periodo)=(2*pi)/b   des-de-fase(x)= -c/b  des-y=+d o -d 
x=[0:0.001:(2*pi)];
y=3*sin(pi*x*10);
%plot(x,y)


%% Parametros de entrada 
I= 600e-6; %amplitud en microamperiros uA
R= 7.1e3; %es la impendancia de estimulación 
V= I*R;
S= 15; %tiempo de estimulacion en segundos  
%S2 = 1:(S*60); %tiempo de estimulacion en seguntos 

%t = [0:0.0083:S];%length(S)]; %vector de tiempo segundos 1/60=0.016667  1/120   %t = [0:0.0083:0.33];% vector de tiempo
t = [0:0.01:S]; %tiempo en milisegundos
A = I ;%amplitud 
pha = 0; %fase
f = (0:640); %rango de frecuencia 
l = length(t);
f2= datasample(f,l); %frecuencia para aplicar de forma aleatoria 
T = 1./f; %periodo

%% funcion seno para ruido de corriente altena 
N = A*sin(t.*f2);
%N= A.*sin(2.*pi.*f2.*t+pha);
plot(t,N, 'k')
xlabel('Time')
ylabel('Current (uA)')

figure
histogram(N)

%% procedemos a obtener su frecuencia por  FFT

y = fft(N);
%figure
%plot(abs(y))
xlabel('frecuencia')
ylabel('amplitud')


