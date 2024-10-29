close all, clear all, clc
%% poisson distribution 
%observaciones 
T= 0.05;
t= [0:0.01:1.400];
N= 200;
n= N*t./T.*exp(-t./T);
figure
plot(t,n)

ylabel('eventos (liberacion de vesiculas)')
xlabel ('time s')

%% ejemplo de poisson 

% X= [0:100];
% for i=1:numel(X)-1
% x=X(i);%70; % numeros de veces que ocurre un evento durante un intervalo definido ESTE EJEMPLO t 1.4s
% mu= 4;%mean(n);% probabilidad de ocurrencia es la misma para cualesquiera de los intervalos de igual longitud
% P= (exp(-mu)*mu^x)/factorial(x);
% P2(i+1)=P;
% end 
% 
% figure
% plot(X,P2)


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

figure
plot(t,P4)
ylabel('probabilidad acumulada')
xlabel ('time s')








%   for i= numel(n)-1
%       u= 1;  %promedio de <n>/t
%       T = 0.02; %tiempo de intervalo 
%       %T = [0:0.01:1.4]; %tiempo de intervalo 
%       nu=n(i) ; %numero esperado 
%       %Pn(i+1) =(((u.*T).^n)/factorial(n)).*exp(-u.*T);
%       Pn(i+1)=(1-exp(-nu./T));
% 
%  end 
% figure 
% plot(t,Pn)



% %% poisson distribution 
% %Pn probabilidad de n 
% u = 1; %promedio de <n>/t
% T = [0:100]; %tiempo de intervalo 
% n = 100; %numero esperado 
% %Pn = (((u.*T).^n)/factorial(n)).*exp(-u.*T);
% Pn=(1-exp(-n./T));
% figure 
% hold on
% plot(T,Pn)