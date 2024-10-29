%% modelo de hh
 clear all 
 clc
 %% Voltaje y tiempo 
t = [1:500];%tiempo en ms 
vt=t;
contador=1;
while contador<=125
vt(:,contador) = (-80);
contador = contador+1;
 end 
while contador<=250
vt(:,contador) = (-100);
contador = contador+1;
end 
while contador<= 350   
vt(:,contador) = 1.4*vt(:,contador)-450;
contador = contador+1;
 end 
while contador<=500
vt(:,contador) = -80;
contador = contador+1;
 end 
v = vt; %1.4*t-600;
v0= v(150);
plot (t,v)
hold on 
%% Constantes de velocidad para cada estado, son dependientes de voltaje
%sodio
%abierto
am = (0.1.*(25-v))./exp(2.5-0.1.*v)-1;
Bm = 4.*exp(-v./18);

am0 = (0.1.*(25-v0))./exp(2.5-0.1.*v0)-1;
Bm0 = 4.*exp(-v0./18);
%cerrado
ah = 0.07.*exp(-v./20); 
Bh = 1./exp(3-0.1.*v)+1;

ah0 = 0.07.*exp(-v0./20); 
Bh0 = 1./exp(3-0.1.*v0)+1;
%potasio
%abierto
an = (0.01.*(10-v))./exp(1-0.1.*v);
Bn = 0.125.*exp(-v./80);

an0 = (0.01.*(10-v0))./exp(1-0.1.*v0);
Bn0 = 0.125.*exp(-v0./80);
%% Estados del canal 
%parametros para sodio 
%abierto 
mi = am/(am+Bm);
tm = 1./(am+Bm);
m0 = am0/(am0+Bm0);
m = mi-(mi-m0).*exp(-t./tm);

dM = am.*(1-m)-Bm.*m; %dM/dt
plot(dM)
M = trapz(dM);
%cerrado 
hi = ah/(ah+Bh);
th = 1./(ah+Bh);
h0 = ah0/(ah0+Bh0);
h = hi-(hi-h0).*exp(-t./th);

dH = ah.*(1-h)-Bh.*h; %dM/dt
plot(dH)
H = trapz(dH);
%parametros para potasio
%abierto
ni = an/(an+Bn);
tn = 1./(an+Bn);
n0 = an0/(an0+Bn0);
n = ni-(ni-n0).*exp(-t./tn);

dN = an.*(1-n)-Bn.*n; %dM/dt
plot(dN)
N = trapz(dN);
%% Forma de ecuacion general 
%V= ((-Gna*(m^3)*h*(v-vna))+(-Gk*(n^4)*(v-vk))+(-gl*(v-vl))+Ia)/C;