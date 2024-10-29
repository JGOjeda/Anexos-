function [Vd,hd,md,nd,th,tm,hn,mn,nn,gNa,gK,v] = fcn(I,V,h,m,n)

%valores constates
C = 1;
gLn = 0.3;

VL = -54.4;
VK = -77;
VNa = 50;
gKn = 36;
gNan = 120;

Veq = -65;
v=V-Veq;

%velocidades de reaccion 
%potasio
ah = 0.07*exp(-v/20);
bh = 1/(1+exp((30-v)/10));
th = 1/(ah+bh);
hn = ah(1,1)/(ah+bh);

%sodio activado
am =(0.1)*(25-v)/(exp((25-v)/10)-1);
bm = 4*exp(-v/18);
tm = 1/(am+bm);
mn = am(1,1)/(am+bm);

%sodio inactivado 
an = (0.01)*(10-v)/(exp((10-v)/10)-1);
bn =  0.125*exp(-v/80);
tn = 1/(an+bn);
nn = an(1,1)/(an+bn);

%derivadas de h,m,n 
gNa=gNan*h*m^3;
gK=gKn*n^4;

%%%%%%%%%%%%%%Calculando las corrientes%%%%%%%%%%
INa=gNa*(v-VNa);
IK=gK*(v-VK);
IL=gLn*(v-VL);
%%%%%%%%%Corriente total de los inoes %%%%%%%%%%%
F=INa+IK+IL;
%%%%%%%%%%funciones de salida%%%%%%%%%%%%
Vd = (-F+I)/C;
hd = ah*(1-h)-bh*h;
md = am*(1-m)-bm*m;
nd = an*(1-n)-bn*n;
