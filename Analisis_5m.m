%Amplitud es un script para obtener datos para graficas de Amplitud en
%microvolt vs tiempo, de los promedios 
close all;
clear all;
clc;


% n = input('escribe el numero de señales a procesar de la 1 a la n: ');
% EEG = input('escribe el canal de la corteza: ');
% ECG = input('escribe el canal del corazon: ');
% fm = input('escribe la frecuencia de muestreo: ');
 Am= input('Escribe la amplificacion realizada:');
 Ctrl= input('Escribe minutos control :');
 M5= input('Escribe minutos de registro 5m:');
 Basal= input('Escribe minutos control :');
 M2= input('Escribe minutos de registro 2m:');
 
 M52=Ctrl+M2;
 Basal2=M5+Basal;
 M22=M2+M5;
 

%abrimos la ubicacion de lo archivos y en listamos sus nombres 
[filename pathname] = uigetfile('*.abf', 'seleccion archivos abf', 'Multiselect', 'on');

%enlistamos nombre de archivos 
     if length(filename(1,:)) > 1
      filename = filename'; %generamos una columna con los nombres de los datos 
      number = length(filename); %contamos cantidad de archivos seleccionados 
     else
        number = length(filename(:,1)); %si solo se selecciona uno, 1 sera el valor 
     end
    
     
     
     
%preparamos bucle
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
    %siBee= si(:,)
       contador= contador+1;             
   end
   
               contadorX = 1;
               contadorY = 1;
               P= 1536;
   while contadorY < contador
       DeltaBN = s2(61, contadorY);
       DeltaBN2= cell2mat(DeltaBN);
       DeltaBN3= DeltaBN2(:,3);
       %DeltaBN4= ((DeltaBN3(900)- min(DeltaBN3))/Am)*1000000; %Obtengo el valor en microvoltios 
       DeltaBN4= ((DeltaBN3(900)- min(DeltaBN3(1:P)))/Am)*1000000; %Obtengo el valor en microvoltios 
       AmpliBN{contadorX,:}= DeltaBN4; %COPIAR Y PEGAR EN SIGMA U OTRO GRAFICADOR
       contadorY= contadorY+1;
       contadorX=contadorX+1;
   end 
   AmpliBN2= cell2mat(AmpliBN);
   AmpliBN2= AmpliBN2';
   
   PromCtrl= mean(AmpliBN2(1:Ctrl));
   DC= std(AmpliBN2(1:Ctrl));
   ErC= DC/sqrt(Ctrl);
   
   Prom5= mean(AmpliBN2(Ctrl:M52));
   D5 =std(AmpliBN2(Ctrl:M52));
   ErD5=D5/sqrt(M5);
   
   PromB= mean(AmpliBN2(M52:Basal));
   DB =std(AmpliBN2(M52:Basal));
   ErDB=DB/sqrt(Basal);
   
   Prom2= mean (AmpliBN2(Basal:M22));
   D2= std(AmpliBN2(Basal:M22));
   ErD2=D2/sqrt(M2);
   
   
   
   plot(AmpliBN2,'.')
   hold on 
%    plot (promCtrl)
%    plot(Prom2)
%    plot(Prom5)
   'TERMINADO :D'
   
%   % acceder en x, #columna :. de archivos y depositamos en una celda vacia 
%             contador3 = 1;
%             contador4 = 1;
%    %DeltaBN= {};
%             while contador3 <= contador
%              s3{contador3,contador4}= s2(:,contador3);
%              contador3= contador3+1;
%              contador4 = contador4+1;
%             end 
%    