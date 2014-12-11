
%-------------------------------------------------------------------------
%              Alejandro Nunez Labielle
%-------------------------------------------------------------------------
% Examples of INIST use with propane
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables

%Exercise of INIST. In this example, an oxygen tank is connected with a
%valve. In the oxygen tank, we have saturated liquid at a pressure equal to
%10 bar. At the valve outlet, the pressure has decreased to 7 bar. 
%We are askeed to obtain the O2 state after the valve, assuming that it is
%isoenthalpic

clear all
close all


load('IND'); % load INIST data
        
        
%Calcular les propietats al estat inicial 
p1=10;%bar pressi?
h1=INIST(IND.O2,'hl_p',p1);%kJ/kg
s1=INIST(IND.O2,'sl_p',p1);%kJ/kgK

%Calcul estat 2
p2=7;%pressi? en bar
h2=h1;
hl2=INIST(IND.O2,'hl_p',p2);
hv2=INIST(IND.O2,'hv_p',p2);
x2=(h2-hl2)/(hv2-hl2);
if x2>1 || x2<0
    Error('ugg. This title is not valid ');
end
% Check that entropy increases
T2=INIST(IND.O2,'tsat_p',p2);
sl2=INIST(IND.O2,'sl_p',p2);
sv2=INIST(IND.O2,'sv_p',p2);
s2=sl2+x2*(sv2-sl2);
Inc_s=s2-s1;
if Inc_s<0
    Error('ugg. Increment of entropy negative');
end
fprintf('Saturated vapour at T2=%f K \n',T2);
fprintf('Outlet quality is %8.4f\n',x2);
fprintf('Delta s = %8.4f kJ/kgK \n',s2-s1);
    