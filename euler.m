%% programa para resolver ecuaciones diferenciales ordinarias por metodo de euler 
clear all; clc; close all

% n= [0:10000];
% a=(1+(1./n)).^n;
% plot (a)
% b= exp(1);
% tu= 4510e6/log(2)

%y2= 4; %condicion inicial 
%%  condiciones iniciales
a=input('introduce condicion inicial en x:');
y=input('introduce condicion inicial en y:');
b=input('Introduce condicion final en x:');
n=10; %numero de pasos 

%% paso 1, incremento de x para tamaño de rectangulo
ix = (b-a)/n; %tamaño del intervalo del rectangulo

%% paso 2 obtenemos integracion area
n = [0:n];
xn = a+n.*ix;
%% paso 3 mostramos ecuacion a integrar 
y(1) = y; %es la condicion inicial 
%f(1) = (0.1*sqrt(y))+(0.4*xn(1)^2); %ecuacion diferencial ejemplo1 dy/dx= (0.1*sqrt(y))+(0.4*xn(1)^2)
f(1) = y-xn(1); %ecuacion diferencial ejemplo2 dy/dx=y-x
z=1;
for i=1:numel(xn)-1
    y(i+1) = y(i)+ix*f(i);% primer valor en columna 2
    %f(i+1) = 0.1*sqrt(y(i))+0.4*(xn(i+1)^2); % primer valor en columna 2 ejemplo 1
    f(i+1) = y(i)-xn(i+1); % primer valor en columna 2 ejemplo 2

end
y(numel(n))
'Terminado :D'




