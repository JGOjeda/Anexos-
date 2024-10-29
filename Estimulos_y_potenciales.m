close all;
clear all;
clc;


% n = input('escribe el numero de señales a procesar de la 1 a la n: ');
% EEG = input('escribe el canal de la corteza: ');
% ECG = input('escribe el canal del corazon: ');
% fm = input('escribe la frecuencia de muestreo: ');
 Am= input('Escribe la amplificacion realizada:');

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
               contador2 = 1;
   while contadorY < contador
       DeltaBN = s2(61, contadorY);
       DeltaBN2= cell2mat(DeltaBN);
       DeltaBN3= DeltaBN2(:,3); % 1 es el estimulo, 2 es el canal vacio, 3 potencial, 4 ritmo cardiaco
       DeltaBN4= ((DeltaBN3(900)- min(DeltaBN3))/Am)*1000000; %Obtengo el valor en microvoltios 
       AmpliBN{contadorX,:}= DeltaBN4; %COPIAR Y PEGAR EN SIGMA U OTRO GRAFICADOR
       
       %Estimulo 
       DeltaBN5= DeltaBN2(:,1);%obtener estimulo 
       Estimulo{:,contadorY}= DeltaBN5*0.09;
      
       %morfologia del potencial 
       DeltaBN6=DeltaBN2(:,3);
       Potencial{:,contador2}= (DeltaBN6/Am)*1000000; % 1 es el estimulo, 2 es el canal vacio, 3 potencial, 4 ritmo cardiaco
       
       %ya que tengo que dar 20 registros, son 240 por 3 horas, entonces
       %seria cada 12 min
       contadorY= contadorY+12;
       contadorX=contadorX+12;
       contador2=contador2+1; 
   end
   Potencial= cell2mat(Potencial);
   Estimulo= cell2mat(Estimulo);
   
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