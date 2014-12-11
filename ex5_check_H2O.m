% example: check INIST against XSteam and append a new pressure
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.
clear
load('IND');
close

tv=linspace(70,400,50);
pv=linspace(0.2,200,20);

for j=1:length(pv)
    
    if j==4 % append one pressure, to see the difference
        IND.H2O=INIST(IND.H2O,'add_p',pv(j));
    end
    for i=1:length(tv)
        t=tv(i);
        s1(i)=XSteam('s_pt',pv(j),t);
        s2(i)=INIST(IND.H2O,'s_pt',pv(j),t+273.15);
    end
    if j==3 
        plot(tv,s1,'ro');
        hold on
        plot(tv,s2,'g');
    else
        plot(tv,s1,'r');
        hold on
        plot(tv,s2,'b');
    end
end

save('IND');