% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.

function [dat,q,w,Tv,pv,hv,sv]=ns_isot_comp(dat,n,Tin,pin,pout)
% T(K), p (bar)
% n intermediate stages vapour compression
% each stage is formed by an isentropic compression followed by
% isobaric cooling until Tin is reached
% initial pressure is pin, final pressure is pout
% returns:
% q: total heat kJ/kg
% w: total work kJ/kg
% Tv: temperature vector (1..2n+1)
% pv: pressure
% hv: enthalpy
% sv: entropy

f=(pout/pin)^(1/n)

Tv(1)=Tin;
pv(1)=pin;

for i=2:2*n+1
    if mod(i,2)==0
        pv(i)=pv(i-1)*f;
    else
        pv(i)=pv(i-1);
        Tv(i)=Tin;
    end
end

for i=1:2*n+1
    dat=INIST(dat,'add_p',pv(i));   
end


for i=1:2:2*n+1
    hv(i)=INIST(dat,'h_pt',pv(i),Tv(i));
    sv(i)=INIST(dat,'s_pt',pv(i),Tv(i));    
end

for i=2:2:2*n
    sv(i)=sv(i-1);
    Tv(i)=INIST(dat,'t_ps',pv(i),sv(i));
    hv(i)=INIST(dat,'h_pt',pv(i),Tv(i));
end

q=0;
w=0;

for i=1:2:2*n-1
    w=w+hv(i+1)-hv(i);
end

for i=2:2:2*n
    q=q+hv(i+1)-hv(i);
end

end