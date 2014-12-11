% Example:  Linde cycle for N2 liquefaction
% Multiple stage isentropic compression
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.

function ex7_linde_N2_liq

close all

global IND;

load('IND');

plow=1; % bar
phigh=200; % bar

T1=300;
T3=164.5; % initial guess

mg=1 % kg/s


% point 1: cycle begins at ambient temperature and pressure

% Multiple stage compression
n=5; 

[IND.N2,qc,wc,Tvec,pvec,hvec,svec]=ns_isot_comp(IND.N2,n,T1,plow,phigh);


save('IND','IND');

T3=fsolve(@hastobezero,T3)

    function e=hastobezero(T3)
        
        p1=plow;
        T1=Tvec(1);
        h1=hvec(1);
        s1=svec(1);

        % point 2: end of multiple stage compression
        p2=pvec(end); 
        T2=Tvec(end);
        h2=hvec(end);
        s2=svec(end);


        % point 3: end of regenerative cooling
        p3=p2;
        h3=INIST(IND.N2,'h_pt',p3,T3);
        s3=INIST(IND.N2,'s_pt',p3,T3);
        qi=mg*(h3-h2)


        % point 4: end of isoenthalpic expansion
        p4=plow;
        T4=INIST(IND.N2,'tsat_p',p4);
        h4=h3;
        hl=INIST(IND.N2,'hl_p',p4);
        hv=INIST(IND.N2,'hv_p',p4);
        sv=INIST(IND.N2,'sv_p',p4);
        sl=INIST(IND.N2,'sl_p',p4);

        x4=(h4-hl)/(hv-hl)
        s4=sl+x4*(sv-sl);
        if x4>1 
            error('Not wet steam, sorry ');
        end
        x4=(h4-hl)/(hv-hl)

        % point 5: end of separation
        T5=T4
        p5=plow;
        s5=sv;
        h5=hv;

        ml=mg*(1-x4)

        % heat that has to be released by 2->3 process
        abs(qi)

        % heat absorbed by 5->1 process
        (mg-ml)*(h1-h5)

        e=abs(qi)-(mg-ml)*(h1-h5);
    end

for i=1:2:length(pvec)
    INIST_plotisobar(IND.N2,pvec(i));
end

plot(s1,T1,'ro');
plot(s2,T2,'ro');
plot(s3,T3,'ro');
plot(s4,T4,'ro');
plot(s5,T5,'ro');

T5

wc

ml


for i=2:length(pvec)
    plot(svec(i),Tvec(i),'ok')
end

% plot isoenthalpic expansion
ipres=linspace(p4,p3,40);
hh=h3;
is=[];
iT=[];
for i=1:length(ipres)
    if ipres(i)<INIST(IND.N2,'pcrit')
        hl=INIST(IND.N2,'hl_p',ipres(i));
        hv=INIST(IND.N2,'hv_p',ipres(i));
        sl=INIST(IND.N2,'sl_p',ipres(i));
        sv=INIST(IND.N2,'sv_p',ipres(i));
        xx=(hh-hl)/(hv-hl);
        is(i)=sl+xx*(sv-sl);
        iT(i)=INIST(IND.N2,'tsat_p',ipres(i));
    else
        eq=@(Tx) INIST(IND.N2,'h_pt',ipres(i),Tx)-hh;
        tt=fsolve(eq,T3,optimset('Display','none'));
        iT(i)=tt;
        is(i)=INIST(IND.N2,'s_pt',ipres(i),tt);
    end
end
plot(is,iT,'r')


end
