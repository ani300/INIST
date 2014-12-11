% Example: comparison of H2 and pH2 properties
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.% 
clear
close all

load('IND');
p=1;

TsatH2=INIST(IND.H2,'Tsat_p',p)
TsatpH2=INIST(IND.pH2,'Tsat_p',p)

Tv=linspace(17,300,100);
for i=1:length(Tv)
    H2h(i) =INIST(IND.H2,'h_pt',p,Tv(i));
    pH2h(i)=INIST(IND.pH2,'h_pt',p,Tv(i));    
end

plot(Tv,H2h,'r');
hold on
plot(Tv,pH2h,'b');
