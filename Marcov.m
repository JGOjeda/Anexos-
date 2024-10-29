%Ejemplo de cadena de markov 
%estados iniciales 1 y 2 
%1-->2 p:1/2
%2-->1 p:2/3
%1-->1 p:1/2
%2-->2 p:1/3

%estado inicial 
X0=[0;1];

%tabla de convergencia 
%      entrada
%          1   2        
%salida 1 1/2  2/3
%       2 1/2  1/3
%matriz de transicion 
P= [1/2, 2/3; 1/2, 1/3];

%pregunta, probabilidad de estudiar calculo el jueves 
%iniciamos el lunes 
%k0:L k1:M k2:Mi K3:J
K3= P^3*X0

