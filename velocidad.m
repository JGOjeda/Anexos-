%% ejercicio de movimiento 
close all; clc; clear all 
ex={};
%pe={};
ex=cell2mat(ex);
t = [1:length(ex)];
%x = 2+(3*t)+(5*(t.^2));
%v = 3+(10.*t);
%v =  (-5e-5*(t.^2))+(0.0057*t)+1.8496;

%v =  (-7e-5*(t.^2))+(0.007*t)+1.8649;%<--- 5min
%v =  (-7e-5*(t.^2))+(0.007*t)+2.1889;%<--- +5min
%v =  (-7e-5*(t.^2))+(0.007*t)+1.5409;%<--- -5min

%v = (-2e-5*(t.^2))+(0.0027*t)+1.1569;%<--- 4min
%v = (-2e-5*(t.^2))+(0.0027*t)+1.2333;%<--- +4min
%v = (-2e-5*(t.^2))+(0.0027*t)+0.9545;%<--- -4min
%v = (-2e-5*(t.^2))+(0.0027*t)+1.0939;%<--- 4min

%v =  (4e-6*(t.^2))-(0.0006*t)+0.5125;%<--- 2min
%v =  (4e-6*(t.^2))-(0.0006*t)+0.6296;%<--- +2min
v =  (4e-6*(t.^2))-(0.0006*t)+0.3953;%<--- -2min


plot(t,v)
hold on 
plot(ex)
R= corrcoef(ex,v);
 %% derivamos la funcion 
% dv= (-14e-5*(t))+(0.007);
% plot (dv)
% pe=cell2mat(pe);
% hold on 
% plot(pe)
