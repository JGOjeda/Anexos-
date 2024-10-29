V=[-100,-50,10,100,150,200];
for i=1:numel(V)
    if V(i)<-10 %-80 mV
        tH(i) = exp((V(i)+467)/66.6);
    %elseif V(i)=>-10 %-80 mV
    %    tH(i) = 28+exp(-(V(i)+132)/10.5)
    else 
        tH(i) = 28+exp(-(V(i)+132)/10.5);
    end 
end 