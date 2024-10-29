%% Amplitud es un script para obtener datos para graficas de Amplitud en
%microvolt vs tiempo, de los promedios 
close all;
clear all;
clc;

% n = input('escribe el numero de señales a procesar de la 1 a la n: ');
% EEG = input('escribe el canal de la corteza: ');
% ECG = input('escribe el canal del corazon: ');
% fm = input('escribe la frecuencia de muestreo: ');
 Am= input('Escribe la amplificacion realizada:');
%  Ctl= input('Escribe minutos control :');
%  M2= input('Escribe minutos de registro 2m:');
%  M5= input('Escribe minutos de registro 5m:');

%% abrimos la ubicacion de lo archivos y en listamos sus nombres 
[filename pathname] = uigetfile('*.abf', 'seleccion archivos abf', 'Multiselect', 'on');
%enlistamos nombre de archivos 
     if length(filename(1,:)) > 1
      filename = filename'; %generamos una columna con los nombres de los datos 
      number = length(filename); %contamos cantidad de archivos seleccionados 
     else
        number = length(filename(:,1)); %si solo se selecciona uno, 1 sera el valor 
     end
    
     
     
     
%% preparamos bucle donde todos los datos se abren 
     contador = 1; 
   while contador <= number 
       %damos direccion y nombre del archivo a abrir, es importante sino no
       %jala 
        if length(filename(:,1)) > 1
            file = strcat(pathname,filename(contador))
            file = file{1};
        else
            file = strcat(pathname,filename)
        end
        %Cargamos datos de .abf
        si = abfload(file);
        contador2=1;
        %accesamos a los valores de la 3era columna del registro de la matriz 5000*4*61 para cada archivo
        %hacemos una matriz llamada s2, 
        % #columnas  = al numero de archivos seleccionados 
        % #filas = al numero de Sweeps, en este caso seran 61, 60 + 1 que
        % será el promedio 
            while contador2 <= 61
            s2{contador2,contador}= si(:,:,contador2); 
            contador2=contador2+1;
            end   
       contador= contador+1;             
   end
   
   
   %% procedemos a obtener el valor al pico y el basal 
               contadorX = 1; %este en y 
               contadorY = 1; %este en X
               P= 1536; %tiempo en que debe de aparecer el potencial 
               
   while contadorY < contador
       DeltaBN = s2(61, contadorY);
       DeltaBN2= cell2mat(DeltaBN);
       DeltaBN3= DeltaBN2(:,3);
       DeltaBN4= ((DeltaBN3(900)- min(DeltaBN3(1:P)))/Am)*1000000; %Obtengo el valor en microvoltios, considero tiempo de aparicion  
       AmpliBN{contadorX,:}= DeltaBN4; %<<----COPIAR Y PEGAR EN SIGMA U OTRO GRAFICADOR
%        
       contadorY= contadorY+1;
       contadorX=contadorX+1;
   end 
%% Procedemos  a hacer el vector para graficar 
   AmpliBN2= cell2mat(AmpliBN);
   AmpliBN2= AmpliBN2';
   tiempo = 1:length(AmpliBN2);
   plot(tiempo, AmpliBN2,'.') %se grafica la actividad con valores reales 
   
   %% Normalizacion de amplitudes 
   Norma=mean(AmpliBN2(1:60));
   DeltaBN5= AmpliBN2/Norma;
   DeltaBN5=DeltaBN5';%<--- COPIAR Y PEGAR EN CUALQUIER GRAFICADOR, SON VALORES DE 0 A 1
   AmpliBNNorm{contadorX,:}= DeltaBN5;
   
   
   %% procedemos a obtener la envolvente con la finalidad de encontrar puntos
   %de inflexion 
  %AmpliBN3= cell2mat(AmpliBN)
  contadorp=1;
  contadorpX2=15 % input('intervalo de minutos promediados:');
  contadorpX1=1;

   for i =1: number
%         contadorp=1;
%         contadorpX2=5;
%         contadorpX1=1;
        if contadorpX2<= number
       Envol1 = AmpliBN2(contadorpX1:contadorpX2);
       Envol2 = mean(Envol1)
       Envol{contadorp,:} = Envol2;
        contadorp=contadorp+1;
        contadorpX1=contadorpX1+ 15;% contadorpX2;
        contadorpX2=contadorpX2+ 15;%contadorpX2;
        else 
          '.'  
        end
   end 

   Envol= cell2mat(Envol);
   Envol= Envol';
   Envol3 = repelem(Envol, 15);
%    hold on 
%    plot (Envol3)   
%% Suavizar 
 tiempo2= 1:length(Envol3);
 AmpliBN3= smooth (tiempo2,Envol3,0.1,'rloess');
 hold on 
 plot(AmpliBN3)
%%

 'TERMINADO :D'
   

