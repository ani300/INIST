function dat=INIST_plotisobar( dat,pv )
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.
% INIST_plotisobar: download (if needed) and plot isobar vector
% dat: data
% p: isobar
% returns dat, with appended (if needed) isobar

for i=1:length(pv)
    dat=INIST(dat,'add_p',pv(i));    
end

ok=0;
for j=1:length(pv) % plot isobar number j
   for  i=1:length(dat.isoP)
       if dat.isoP{i}.P==pv(j)
           plot(dat.isoP{i}.s,dat.isoP{i}.T);
           hold on
           ok=ok+1;
           break;
       end       
   end
end

plot(dat.sl,dat.Tsat);
plot(dat.sv,dat.Tsat);

if ok==0 
    error('uhh??)');
end

title(dat.name);
xlabel('s (kJ/kgK)');
ylabel('T (K)');

grid

end

