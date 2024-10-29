%hacemos vector para almacenar datos del script amplitud, delta5
%paramos el script en AmpliBN
clc, clear all 
AmpliN={};%<--- introducimos vactor ya normalizado del excel libro1 en graficas 
number= length(AmpliN)%tiempo del experimento total 
AmpliBN2= cell2mat(AmpliN);

AmpliBN2=AmpliBN2';
promedioC= mean(AmpliBN2(1:60));

plot(AmpliBN2,'.')

AmpliBN2=AmpliBN2';
%%  %% procedemos a obtener la envolvente(integracion trapezoidal) con la finalidad de encontrar puntos
   %de inflexion 
  %AmpliBN3= cell2mat(AmpliBN)
  contadorp=1;
  contadorpX2=10 ;% input('intervalo de minutos promediados:'); %15 es el intervalo ed promedio
  contadorpX1=1;

   for i =1: number
%         contadorp=1;
%         contadorpX2=5;
%         contadorpX1=1;
        if contadorpX2<= number
                Envol1 = AmpliBN2(contadorpX1:contadorpX2);
                Envol2 = mean(Envol1);
                Envol{contadorp,:} = Envol2;
                contadorp=contadorp+1;
                contadorpX1=contadorpX1+ 10;% contadorpX2;
                contadorpX2=contadorpX2+ 10;%contadorpX2;
        else 
          '.'  
        end
   end 

   Envol= cell2mat(Envol);
   Envol= Envol';
   Envol3 = repelem(Envol, 10);
%% agregar promedio 
Envol3(1:60)= promedioC;
%     hold on 
%     plot (Envol3)   
%% Suavizar 
 tiempo2= 1:length(Envol3);
 AmpliBN3= smooth (tiempo2,Envol3,0.07,'loess');
 hold on 
 plot(AmpliBN3)
 
 %% suavizar2 
%  
% tiempo3= 1:length(AmpliBN2);
%  AmpliBN4= smooth (tiempo3,AmpliBN2,0.1,'rloess');
%  hold on 
%  plot(AmpliBN4)
%% obtener pendiente al punto maximo
AmpliBN3=AmpliBN3';
[AmpliM,tiempoM]= max(AmpliBN3(61:215))
%in=  [61:(tiempoM+61)];

P=(AmpliM-promedioC)/tiempoM;
%modelo1
t=[60:256];
A=P*(t);
hold on 
plot (t,A)


 'TERMINADO :D'