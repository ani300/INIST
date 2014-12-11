function ex4_combustion_C3H8
% Combustion LC3H8 / LO2
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.
% Example: liquid phase propellants

species={'C3H8',...
    'CO2',...
    'CO',...
    'O2',...
    'O',...
    'H2',...
    'H',...
    'OH',...
    'H2O'};

global IND; % IND must be declared as global before loading it
load('IND');

% Los propulsantes entran como liquido saturado a la presion de la camara
P0=20; % bar  

TO2=INIST(IND.O2,'tsat_P',P0)

TC3H8=INIST(IND.C3H8,'tsat_P',P0)

% 1 mol C3H8, 5 mol O2

np=[1;0;0;5;0;0;0;0;0];

% neq=hgseq(species,np,2000,P0)


deltah_O2=(INIST(IND.O2,'h_pT',P0,400)-INIST(IND.O2,'hl_P',P0))*INIST(IND.O2,'MM'); % kJ/mol
%deltah_O2=0 % uncomment for gas phase propellants
hO2=hgssingle('O2','h',400)-deltah_O2 % enthalpy at inlet, in hgs reference


deltah_C3H8=(INIST(IND.C3H8,'h_pT',P0,400)-INIST(IND.C3H8,'hl_P',P0))*INIST(IND.C3H8,'MM'); % kJ/mol
%deltah_C3H8=0  % uncomment for gas phase propellants
hC3H8=hgssingle('C3H8','h',400)-deltah_C3H8

Hin=np(1)*hO2+np(4)*hC3H8

    function DeltaH=DeltaH(Tprod)
        comp=hgseq(species,np,Tprod,P0);
        [~,~,~,~,~,~,Hout,~,~]=hgsprop(species,comp,Tprod,P0);
        DeltaH=Hout-Hin;
    end

Tp=fzero(@DeltaH,2500,optimset('Display','iter'))

end

