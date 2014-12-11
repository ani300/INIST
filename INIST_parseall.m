% INIST: download initial IND table
% PLEASE DON'T RUN THIS unless you need it !


return

load('IND','IND')
IND.O2  =parsel('O2'  ,0.065    ,50.430 ,  54.361,    500,          300      , 60,     30    , 2*15.999e-3);
IND.H2=  parsel('H2'  ,0.0736    ,12.964,  13.957 ,   600,          300      , 60,     60    , 2.015e-3);
IND.H2O = parsel('H2O' ,0.065    ,220.640,  275,       700,          400      , 60,     30    , 18.01528e-3);


IND.R134a =parsel('Ethane, 1,1,1,2-tetrafluoro- (R134a)',0.0039,40.5928 ,169.85 ,      455,        400      , 60,     60    ,  102.03e-3);
IND.N2    =parsel('N2' ,0.13    ,33.958,  63.151,       500,        400      , 60,     60    ,  28.01340e-3);


IND.CH4 =parsel('CH4' ,0.11696  ,45.992 ,  90.6941,   500,          300      , 60,     60    , 16.04e-3);
IND.C3H8=parsel('C3H8',0.065    ,42.4766,  85.48  ,   500,          300      , 60,     60    , 44.10e-3);
IND.He=  parsel('helium',0.05      ,2.2746  ,  2.1768 ,   500,      100      , 30,     30    , 4.002602e-3);

IND.pH2= parsel('parahydrogen'  ,0.07042  ,12.8377,  13.8  ,   400,          300      , 60,     60    , 2.015e-3);

save('IND','IND')
