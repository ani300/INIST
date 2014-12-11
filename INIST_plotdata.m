function INIST_plotdata( dat )
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.
% INIST_plotdata: plot substance data

plot(dat.sl,dat.Tsat)
hold on
plot(dat.sv,dat.Tsat)

%
for i=1:length(dat.isoP)
   plot(dat.isoP{i}.s,dat.isoP{i}.T);
end
%

title(dat.name);
xlabel('s (kJ/kgK)');
ylabel('T (K)');

grid

end

