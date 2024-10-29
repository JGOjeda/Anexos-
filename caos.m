%script para hacer caos 
clear all; clc
r= [0:0.5:2.6];
r= 2.6;
xn= 0.4;
contador =1;
while contador <= 100
xn=r.*xn.*(1-xn);
xn1{contador,:}= xn;
poblacion{contador,:}=
contador = contador+1;
end 

xn2 = cell2mat(xn1);
xn2 = xn2';
plot(xn2)
%plot(r,xn2)