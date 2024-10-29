clc; clear all; close all 

%caso 1
x0 = [2 0]; %condion inicial 
mu = 1; 
tspan=[0 30];
u=0;
%solucion de la edo 
[ts,y]= ode45(@(t,x)VanDerPol(t,x,u,mu), tspan,x0)

figure 
plot(ts,y(:,1))





function dx = VanDerPol(t,x,u, mu)
 %estados
 x1 = x(1);
 x2 = x(2);
 
 %entradas
 
 %ecuaciones diferenciales 
 dx1 = x2;
 dx2 = mu*(1-x1^2)*x2-x1;
 
 dx = [dx1; dx2]
end