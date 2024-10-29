%programa para medir ley de ohm 
t=[0:10];
R= [1,1,1,1,1,3,5,10,9,8,7,3,1,1,0.5, 0.5, 0, 0, 0.5, 1, 1,1,1,1,1];
I= 2;
V1= I*R;
V1=smooth(V1);
plot (V1)
ylabel('Voltage (V)')
xlabel ('time(ms)')
title("Ohm's Law")