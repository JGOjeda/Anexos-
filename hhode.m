%% Find the Order of Method for Predictor-Corrector Method
clear all;
h=0.1 %set initial step size
t=0:h:2;
ystar(1)=1.0; %initial condition
y=-2*exp(-5*t)+3*exp(-4*t); %exact solution
for j=1:8; %h is the step size
 harray(j)=h; %record the h-value
 h=h/2; %create next h-value
 t=0:h:2;
 clear ystar;
 ystar(1)=1;
 y=-2*exp(-5*t)+3*exp(-4*t);
 %PC method for finding ystar
 for i = 1:3 % find the first four elements using RK4
 k1 = 2*exp(-5*t(i))-4*ystar(i);
 k2 = 2*exp(-5*(t(i)+h/2))-4*(ystar(i)+(h/2)*k1);
 k3 = 2*exp(-5*(t(i)+h/2))-4*(ystar(i)+(h/2)*k2);
 k4 = 2*exp(-5*(t(i)+h))-4*(ystar(i)+(h)*k3);
 ystar(i+1) = ystar(i) + h/6*(k1 + 2*k2 + 2*k3 + k4);
 end
 for i = 4:length(t)-1 % P-C Method
 yp=ystar(i)+(h/24)*(55*(2*exp(-5*t(i))-4*ystar(i))-59*(2*exp(-5*t(i-1))-4*ystar(i-1))+37*(2*exp(-5*t(i-2))-4*ystar(i-2))-9*(2*exp(-5*t(i-3))-4*ystar(i-3)));
 yc=ystar(i)+(h/24)*(9*(2*exp(-5*t(i+1))-4*yp)+19*(2*exp(-5*t(i))-4*ystar(i))-5*(2*exp(-5*t(i-1))-4*ystar(i-1))+1*(2*exp(-5*t(i-2))-4*ystar(i-2)));
 ystar(i+1)=yc+(19/270)*(yp-yc);
 end
 p(j)=error(ystar,y) %record the error at the coresponding hvalue
end
%plot on a loglog scale
loglog(harray,p)
title('Predictor-Corrector Method - Step Size vs. Error');
xlabel('Step Size (h)');