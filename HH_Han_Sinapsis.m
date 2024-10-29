clear all; clc; close all

%%   Stimulation time 
stimulationTime = 600; %in ms
deltaT= 0.01;%el intervalo afecta a la funcion 
t=0:deltaT:stimulationTime;

%   Specify the external current
changeTimes = [0]; % in ms
currentLevels = [-0.40]; %change this to see effect of different currents on milivoltage (suggested values: 3,20,50,1000)
%Set externally applied current across time 
%Here, first 500 timesteps are at current of 50, next 1500 timesteps at
%current zero (resets resting potential of neuron), and the rest of 
%timesteps are at constan current 
%I(1:500) = currentLevels; I(501:200)= 0; I(2001:numel(t)) = currentLevels;
%comment out the above line and uncomment the line below for constant current, and observe effects on voltage timecurse
I(1:numel(t)) = currentLevels;


%%   Constant parameters
%All of these can be found in table 3 art: Hodking Huxley 1952
C=1;%uF/cm2
E_Na = 55;%115; %50;mV
E_K=-90;%-12;%-77; mV 
E_Ca= 120;%mV
E_L=-65;%10.613;%-54.4;mV %%%%%%<-----   REVISAR 
gbar_Na=35;%120; %mOhm/cm2 o uS/cm2
gbar_K=9;%36;%mOhm/cm2 o uS/cm2
gbar_Ca=3;
g_L=9;%0.3;%mOhm/cm2 o uS/cm2

%%   Set the initial states 
V=0; %baseline voltage 
%potasio activado 
alpha_n = -0.01*(V+34)/exp(-0.1*(V+34)-1);
beta_n = 0.125*exp(-V+44/80); 

%sodio activado 
alpha_m = -0.1*((V+35)/(exp(-0.1*(V+35)-1))); %equation 20
beta_m = 4*exp(-(V+60)/18); %Equation 21
%sodio inactivado 
alpha_h = 0.07*exp(-(V+58)/20); %Equation 23
beta_h = 1/(exp(-0.1*(V+28)+1)); %Equation 24

%Calcio 
tM = 0.612+1/(exp(-(V+132)/16.7)+exp((V+16.8)/18.2));
if V<-10 %-80 mV
    tH = exp((V+467)/66.6);
else 
    tH = 28+exp(-(V+132)/10.5);
end 

%Estados inf
n(1) = alpha_n/(alpha_n+beta_n); %equation 9   POTASIO 
m(1) = alpha_m/(alpha_m+beta_m); %equation 18  SODIO A
h(1) = alpha_h/(alpha_h+beta_h); %equation 18  SODIO I
M(1) = 1/(1+exp(-(V+57)/6.2));   %Calcio 
H(1) = 1/(1+exp((V+81)/4));      %Calcio 

 for  i=1:numel(t)-1 %Compute coefficients, currents, and derivates at each time 
    
    %   Calculate the coefficients velocidades de reaccion 
    %Equations here are same as above, just calculating at each time step
    %potasio 
    alpha_n(i) = -0.01*(V(i)+34)/exp(-0.1*(V(i)+34)-1);
    beta_n(i) = 0.125*exp(-V(i)+44/80);
    
    %sodio activado 
    alpha_m(i) = -0.1*((V(i)+35)/(exp(-0.1*(V(i)+35)-1)));
    beta_m(i) = 4*exp(-(V(i)+60)/18); %Equation 21
    %sodio inactivado 
    alpha_h(i) = 0.07*exp(-(V(i)+58)/20); %Equation 23
    beta_h(i) = 1/(exp(-0.1*(V(i)+28)+1)); %Equation 24
    
    %Calcio 
    tM(i) = 0.612+1/(exp(-(V(i)+132)/16.7)+exp((V(i)+16.8)/18.2));
    if V(i)<-10 %-80 mV
        tH(i) = exp((V(i)+467)/66.6);
    else 
        tH(i) = 28+exp(-(V(i)+132)/10.5);
    end 
    
    %   Calculate the currrents
    %Sodio
    I_Na = (m(i)^3)*gbar_Na*h(i)*(V(i)-E_Na); %equations 3 and 14
    I_Na2(i+1) = (m(i)^3)*gbar_Na*h(i)*(V(i)-E_Na); 
    %potasio
    I_K = (n(i)^4)*gbar_K*(V(i)-E_K);%Equations 4 and 6
    I_K2(i+1) = (n(i)^4)*gbar_K*(V(i)-E_K);
    %calcio 
    I_Ca = (M(i)^2)*gbar_Ca*(H(i))*(V(i)-E_Ca);
    I_Ca2(i+1) = (M(i)^2)*gbar_Ca*(H(i))*(V(i)-E_Ca);
    
    I_L = g_L*(V(i)-E_L); %Equations 5
    %I_ion = I(i)-I_K-I_Na-I_L;
    I_ion = I(i)-I_K-I_Na-I_L-I_Ca;
    %I_ion2(i+1) = I(i)-I_K-I_Na-I_L;
    I_ion2(i+1) = I(i)-I_K-I_Na-I_L-I_Ca;
    
    %   Calculate the derivates usion Euler first order approximation,    States open-close 
    V(i+1) = V(i) + deltaT*I_ion/C;
    %POTASIO  Dn/Dt = Alpha(V)(1-n)-B(v)(n)
    n(i+1) = n(i) + deltaT*5*(alpha_n(i)*(1-n(i)) - beta_n(i)*n(i)); %Equation 7
    %SODIO    Dm/Dt = Alpha(V)(1-m)-B(v)(m)
    m(i+1) = m(i) + deltaT*5*(alpha_m(i)*(1-m(i)) - beta_m(i)*m(i)); %Equation 15
    h(i+1) = h(i) + deltaT*5*(alpha_h(i)*(1-h(i)) - beta_h(i)*h(i)); %Equation 16
    %CALCIO    DM/Dt = tM(-M+M)
    M(i) = M(i) + deltaT*tM.^-1*((tM(i)^-1)*(-M(i)+M(i)));%1/(1+exp(-(V(i)+57)/6.2));
    H(i) = H(i) + deltaT*tH.^-1*((tH(i)^-1)*(-H(i)+H(i)));%1/(1+exp((V(i)+81)/4));
%     
 end 


V = V-70; %Set restng potential to -70mV

%%   Plot Voltage
plot(t,V,'LineWidth',1)
hold on
legend({'Voltage'})
ylabel('Voltage (mv)')
xlabel ('time(ms)')
title('Voltage over time in simulated neuron')


%%   Plot conductance 
figure
p1 = plot(t,gbar_K*n.^4,'LineWidth',2);
hold on
p2 = plot(t,gbar_Na*(m.^3).*h,'r','LineWidth',1);
legend([p1, p2],'Conductance for potassium','Conductnce for Sodium')
ylabel('Conductance')
xlabel('time(ms)')
title('Conductance for Potassium and Sodium ions in Simulated Neuron')

%%   Plot total  current  
figure
plot(t,I_ion2,'LineWidth',1)
hold on
plot(t,I)
legend({'Current'})
ylabel('Current (pA)')
xlabel ('time(ms)')
title('Current over time in simulated neuron')
% 
% %   Plot  Na current  
% figure
% plot(t,I_Na2,'LineWidth',1)
% hold on
% legend({'Current Na'})
% ylabel('Current (pA)')
% xlabel ('time(ms)')
% title('Na Current over time in simulated neuron')
% 
% %   Plot  K current  
% figure
% plot(t,I_K2,'LineWidth',1)
% hold on
% legend({'Current K'})
% ylabel('Current (pA)')
% xlabel ('time(ms)')
% title('Na Current over time in simulated neuron')

%%   Plot constants  
% figure
% p1 = plot( alpha_n,'LineWidth',2);
% hold on
% p2 = plot(beta_n,'r','LineWidth',1);
% legend([p1, p2],'Alpha_n','Beta_n')
% ylabel('Rate constant')
% xlabel('time(ms)')
% title('Rate constant for K')
% 
% figure
% p1 = plot( alpha_m,'LineWidth',2);
% hold on
% p2 = plot(beta_m,'r','LineWidth',1);
% legend([p1, p2],'Alpha_m','Beta_m')
% ylabel('Rate constant')
% xlabel('time(ms)')
% title('Rate constant for Na')
% 
% 
% figure
% p1 = plot( alpha_h,'LineWidth',2);
% hold on
% p2 = plot(beta_h,'r','LineWidth',1);
% legend([p1, p2],'Alpha_h','Beta_h')
% ylabel('Rate constant')
% xlabel('time(ms)')
% title('Rate constant for Na')