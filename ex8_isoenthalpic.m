% Example: Plot N2 isoenthalpic lines
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.
clear
close all
load('IND');

pvec=logspace(log10(1),log10(399),10)

IND.N2=INIST_plotisobar(IND.N2,pvec);
save('IND','IND');

hold on;

T0=linspace(75,250,10);

for j=1:length(T0)
    % plot isoenthalpic expansion
    hh=INIST(IND.N2,'h_pt',pvec(end),T0(j));
    is=[];
    iT=[];
    for i=1:length(pvec)
        if pvec(i)<INIST(IND.N2,'pcrit')
            hl=INIST(IND.N2,'hl_p',pvec(i));
            hv=INIST(IND.N2,'hv_p',pvec(i));
            sl=INIST(IND.N2,'sl_p',pvec(i));
            sv=INIST(IND.N2,'sv_p',pvec(i));
            xx=(hh-hl)/(hv-hl);
            if xx<=1 && xx>=0
                sat=1;
                is(i)=sl+xx*(sv-sl);
                iT(i)=INIST(IND.N2,'tsat_p',pvec(i));              
                continue;
            end
        end
        eq=@(Tx) INIST(IND.N2,'h_pt',pvec(i),Tx)-hh;
        tt=fsolve(eq,T0(j),optimset('Display','none'));
        iT(i)=tt;
        is(i)=INIST(IND.N2,'s_pt',pvec(i),tt);
    end
    plot(is,iT,'-r')
end

axis( [2 6 50 300])