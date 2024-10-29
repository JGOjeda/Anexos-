%% metodo numericos 
%metodos de euler 
clear all; clc; close all
%declarar nuestras condiciones iniciales 
xi=0;  yi=1;
%declarar el tamaño de paso 
h= 0.001;
%declarar el punto final 
xf = 4;
%agregar la ecuacion diferencial
f = @(x,y) -2*x^3+12*x^2-20*x+8.5;

%% comenzar metodo de euler
n = 2; %contador
for i=xi:h:xf
fxy = f(xi(n-1),yi(n-1));
yi(n) = yi(n-1)+h*fxy;
xi(n) = xi(n-1)+h;
n = n+1;
end
plot(xi,yi,'.')

y2=trapz(yi);









