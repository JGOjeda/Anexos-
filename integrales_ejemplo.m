%integrales 
clear all 
clc 
% t=[-3:0.1:2];
% f=((t<=-1).*(t+1))+((t>-1).*(t.^2));%+((t>=1).*(2-t));
% f=f(1:40);
% f2=(t>=1).*(2-t);
% f2=f2(41:end);
% 
% %union de vectores
% f3=[f,f2];
% plot(t,f3)
% 
% %intergracion 
% INf =trapz(f);
% INf2=trapz(f2);
% INf3=trapz(f3);
% inf4=INf3/10;

x=[-2:2];

y=x*1;
%fun=@(x) x*1;
plot(x,y)

i=trapz(y);
%i2=integral(@(x)fun(x,5));
'Terminado :D'


