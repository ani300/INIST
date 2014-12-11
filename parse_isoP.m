function isoP = parse_isoP(fname,P)
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.
% parse_isoP: reads isobaric data file 
% fname: name
% P: pressure (bar)

T=[];

u=[];
v=[];
h=[];
s=[];


nl=0;
fi=fopen(fname,'r');
l=fgets(fi); % read first line (header) and ignore it
while ~feof(fi)
    l=fgets(fi); % read one line
    nl=nl+1;
    l(end)=[]; % supress \n character at the end
    % fprintf('<%s>\n',l);
    c=strsplit(l); % split string into words
    T(nl)=sscanf(c{1},'%g');    
    v(nl)=sscanf(c{4},'%g');
    u(nl)=sscanf(c{5},'%g');
    h(nl)=sscanf(c{6},'%g');
    s(nl)=sscanf(c{7},'%g');    
end
fclose(fi);

isoP.P=P;
isoP.T=T;
isoP.v=v;
isoP.u=u;
isoP.h=h;
isoP.s=s;

end