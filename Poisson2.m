close all, clear all, clc
%% poisson distribution 
%observaciones 
T= 0.05;
t= [0:0.001:1.400];
N= 50;
n= N*t./T.*exp(-t./T);
figure
plot(t,n)

ylabel('eventos (liberacion de vesiculas)')
xlabel ('time s')
xlim([0 0.05])





%% ajuste de liberacion de vesiculas por poisson 

X= n;%[0:100];
for i=1:numel(X)-1
x=round(X(i));%70; % numeros de veces que ocurre un evento durante un intervalo definido ESTE EJEMPLO t 1.4s
mu= mean(n);% probabilidad de ocurrencia es la misma para cualesquiera de los intervalos de igual longitud
P= (exp(-mu)*mu^x)/factorial(round(x)); %funcion de probabilidad de poisson 
P2(i+1)=P;
P4(i+1)=sum(P2);  % funcion de densidad de probabilidad  de poisson 
end 

%opcional 
p3=smooth(P2);
figure
plot(t,p3)
ylabel('probabilidad de eventos')
xlabel ('time s')
xlim([0 0.05])

figure
plot(t,P4)
ylabel('probabilidad acumulada')
xlabel ('time s')
xlim([0 0.05])
