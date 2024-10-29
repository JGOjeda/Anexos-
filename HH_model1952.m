clear all; clc; close all

%%   Stimulation time 
stimulationTime = 100; %in ms
deltaT= 0.01;
t=0:deltaT:stimulationTime;


%   Specify the external current
changeTimes = [0]; % in ms
currentLevels = [10]; %change this to see effect of different currents on nA (suggested values: 3,20,50,1000)

%Set externally applied current across time 
%Here, first 500 timesteps are at current of 50, next 1500 timesteps at
%current zero (resets resting potential of neuron), and the rest of 
%timesteps are at constan current 
%I(1:600) = currentLevels; I(601:2000)= 0; I(2001:numel(t)) = currentLevels;
%comment out the above line and uncomment the line below for constant current, and observe effects on voltage timecurse
I(1:numel(t)) = currentLevels;
%I(1:3040)= -80; I(3041:15340)=-100; I(15340:25340)=((700/500).*t(15340:25340))-(7869/25); I(25341:numel(t))=-80;
%I(1:3040)= -80; I(3041:15340)=-100; 
figure
plot(t,I)
%%   Constant parameters
%All of these can be found in table 3 art: Hodking Huxley 1952
gbar_K=36; gbar_Na=220; g_L=0.3;
E_K=-12; E_Na = 115; E_L=10.6; %%%%%%<-----   REVISAR 
C=1;

%%   Set the initial states 
V=0; %baseline voltage 
alpha_n = 0.01*((10-V)/(exp((10-V)/10)-1)); %equation 12
beta_n = 0.125*exp(-V/80); %Equation 13
alpha_m = 0.1*((25-V)/(exp((25-V)/10)-1)); %equation 20
beta_m = 4*exp(-V/18); %Equation 21
alpha_h = 0.07*exp(-V/20); %Equation 23
beta_h = 1/(exp((30-V)/10)+1); %Equation 24 

n(1) = alpha_n/(alpha_n+beta_n); %equation 9
m(1) = alpha_m/(alpha_m+beta_m); %equation 18
h(1) = alpha_h/(alpha_h+beta_h); %equation 18


for  i=1:numel(t)-1 %Compute coefficients, currents, and derivates at each time 
    
    %   Calculate the coefficients 
    %Equations here are same as above, just calculating at each time step
    alpha_n(i) = 0.01*((10-V(i))/(exp((10-V(i))/10)-1));
    beta_n(i) = 0.125*exp(-V(i)/80);
    alpha_m(i) = 0.1*((25-V(i))/(exp((25-V(i))/10)-1));
    beta_m(i) = 4*exp(-V(i)/18);
    alpha_h(i) = 0.07*exp(-V(i)/20);
    beta_h(i) = 1/(exp((30-V(i))/10)+1);
    
    
    %   Calculate the currrents
    I_Na = (m(i)^3)*gbar_Na*h(i)*(V(i)-E_Na); %equations 3 and 14
    I_Na2(i+1) = (m(i)^3)*gbar_Na*h(i)*(V(i)-E_Na); 
    I_K = (n(i)^4)*gbar_K*(V(i)-E_K);%Equations 4 and 6
    I_K2(i+1) = (n(i)^4)*gbar_K*(V(i)-E_K);
    I_L = g_L*(V(i)-E_L); %Equations 5
    I_ion = I(i)-I_K-I_Na-I_L;
    I_ion2(i+1) = I(i)-I_K-I_Na-I_L;
    
    
    %   Calculate the derivates usion Euler first order approximation,    States open-close 
    V(i+1) = V(i) + deltaT*I_ion/C;
    n(i+1) = n(i) + deltaT*(alpha_n(i)*(1-n(i)) - beta_n(i)*n(i)); %Equation 7
    m(i+1) = m(i) + deltaT*(alpha_m(i)*(1-m(i)) - beta_m(i)*m(i)); %Equation 15
    h(i+1) = h(i) + deltaT*(alpha_h(i)*(1-h(i)) - beta_h(i)*h(i)); %Equation 16
    
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
plot(t,I, 'r','LineWidth',2)
legend({'Current'})
ylabel('Current (pA)')
xlabel ('time(ms)')
title('Current over time in simulated neuron')

%   Plot  Na current  
figure
plot(t,I_Na2,'LineWidth',1)
hold on
legend({'Current Na'})
ylabel('Current (pA)')
xlabel ('time(ms)')
title('Na Current over time in simulated neuron')

%   Plot  K current  
figure
plot(t,I_K2,'LineWidth',1)
hold on
legend({'Current K'})
ylabel('Current (pA)')
xlabel ('time(ms)')
title('Na Current over time in simulated neuron')

%%   Plot constants  
figure
p1 = plot( alpha_n,'LineWidth',2);
hold on
p2 = plot(beta_n,'r','LineWidth',1);
legend([p1, p2],'Alpha_n','Beta_n')
ylabel('Rate constant')
xlabel('time(ms)')
title('Rate constant for K')

figure
p1 = plot( alpha_m,'LineWidth',2);
hold on
p2 = plot(beta_m,'r','LineWidth',1);
legend([p1, p2],'Alpha_m','Beta_m')
ylabel('Rate constant')
xlabel('time(ms)')
title('Rate constant for Na')


figure
p1 = plot( alpha_h,'LineWidth',2);
hold on
p2 = plot(beta_h,'r','LineWidth',1);
legend([p1, p2],'Alpha_h','Beta_h')
ylabel('Rate constant')
xlabel('time(ms)')
title('Rate constant for Na')

%% plot states
figure 
p1 = plot(t, n,'.');
hold on 
p2 = plot(t, m,'o');
p3 = plot(t, h,'s');
title('n(.), m(o), h(s)')
ylabel('State probability')
xlabel('time(ms)')








