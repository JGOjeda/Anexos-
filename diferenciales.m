clc; clear all
%tiempo de integracion 
tspan = (0:0.1:5);
%CI
y0 = [1,0];
%solver 
[t,y] = ode45(@miODE, tspan,y0);

%graficar 
plot (t,y(:,1),'r'); hold on;
plot (t,y(:,2),'b');
legend ('y1', 'y2'); xlabel ('tiempo'); ylabel('y'),

%edo
function dy=miODE(t,y)
dy(1) = y(2)+1;
dy(2) = y(1)*y(2)-6;
dy = [dy(1);dy(2)];
end
