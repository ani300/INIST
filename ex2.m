% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.
% example 2
% check enthalpy difference in hgs and INIST

clear
close

load('IND')
INIST_plotisobar(IND.C3H8,[1,10])

% check that difference is similar, despite the reference value is
% different

hgssingle('C3H8','h',400)-hgssingle('C3H8','h',390) % kJ/mol
(INIST(IND.C3H8,'h_pt',1,400)-INIST(IND.C3H8,'h_pt',1,390))*INIST(IND.C3H8,'MM') % kJ/kg


% extend hgs to consider vaporisation enthalpy

% enthalpy difference between 400K at 1 bar and saturated liquid at 1 bar
deltaH=(INIST(IND.C3H8,'h_pt',1,400)-INIST(IND.C3H8,'hl_p',1))*INIST(IND.C3H8,'MM') % kJ/kg



