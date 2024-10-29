%% modelo de hh
 clear all 
 clc
%% Voltaje y tiempo 
t=[0:100];%tiempo en ms 

%rampa
vt=t;
contador=1;
% while contador<=25
% vt(:,contador) = (-80);
% contador = contador+1;
%  end 
% while contador<=125
% vt(:,contador) = (-100);
% contador = contador+1;
% end 
% while contador<=226
% vt(:,contador) = 1.4*vt(:,contador)-275;%-600;
% contador = contador+1;
%  end 
% while contador<=251
% vt(:,contador) = -80;
% contador = contador+1;
%  end 
v=-63; %este lo voy a cambiar por una rampa
%% Constantes de velocidad para cada estado, son dependientes de voltaje 
%SODIO 
%activacion 
amv = (0.1*(25-v))/(exp(2.5-0.1*v)-1);
Bmv = 4*exp(-v/18);
%inactivacion
ahv = 0.07*exp(-v/20);
Bhv = 1./(exp(3-0.1.*v)+1);

%POTASIO
%activacion
anv = (0.01*(10-v))/(exp(1-0.1*v)-1);
Bnv = 0.125*exp(-v/80);

%% Parametros para funciones de estado
%Activacion SODIO 
am0 = (0.1*(25-0))/(exp(2.5-0.1*0)-1);%condicion inicial V=0
Bm0 = 4*exp(-0/18);%condicion inicial V=0
m0 = am0/(am0+Bm0);
mi = amv./(amv+Bmv); Tm = 1./(amv+Bmv);

%Inactivacion SODIO
ah0 = 0.07*exp(-0/20);%condicion inicial V=0
Bh0 = 1/(exp(3-0.1*0)+1);%condicion inicial V=0
h0 = ah0/(ah0+Bh0);
hi = ahv./(ahv+Bmv); Th = 1./(ahv+Bhv);

%activacion POTASIO
an0 = (0.01*(10-0))/(exp(1-0.1*0)-1);%condicion inicial V=0
Bn0 = 0.125*exp(-0/80);%condicion inicial V=0
n0 = an0/(an0+Bn0);
ni = anv./(anv+Bnv);  Tn = 1./(anv+Bnv); 

%funciones de estado
m = mi-(mi-m0).*exp(-t/Tm);
h = hi-(hi-h0).*exp(-t/Th);
n = ni-(ni-n0).*exp(-t/Tn);

%% Sistema de ecuaciones diferenciales dependientes de voltaje
%ecuaciones diferenciales de funciones de estado 
dm = amv.*(1-m)-Bmv.*m;
dh = ahv.*(1-h)-Bhv.*h;
dn = anv.*(1-n)-Bnv.*n;

%ecuacion diferecial para el voltaje observado 
%parametros
C = 1e-6; %Capacitancia 
gNa = 120e-6; %conductancia
gK = 36e-6;
gl = 0.3e-6;
Vna = 50e-3; %Potencial de inversion o de equilibrio
Vk = -77e-3;
VL = -54.4e-3;
iapp = 10e-9; %Corriente inyectada


ina = -gNa.*(m.^3).*h.*(v-Vna);
ik = -gK.*(n.^4).*(v-Vk);
iL = -gl.*(v-VL);
dv = (ina+ik+iL+iapp)/C;

dv1= fft(dv);
figure (1) 
plot(dv)
xlabel('time')
ylabel('Votage')
figure (2)
plot(dv1)
xlabel('frequency')
ylabel('Votage')
