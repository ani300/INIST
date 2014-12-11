function [ Tsat,Psat,vl,ul,hl,sl ] = parse_sat( fname )
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.
% parse_sat: reads saturarion properties data file 
% fname: name

ul=[];
vl=[];
hl=[];
sl=[];
nl=0;
fi=fopen(fname,'r');
l=fgets(fi); % read first line (header) and ignore it
while ~feof(fi)    
    l=fgets(fi); % read next line    
    nl=nl+1;
    l(end)=[]; % supress \n character at the end
    % fprintf('<%s>\n',l);
    c=strsplit(l); % split string into words
    Tsat(nl)=sscanf(c{1},'%g');
    Psat(nl)=sscanf(c{2},'%g');
    vl(nl)=sscanf(c{4},'%g');
    ul(nl)=sscanf(c{5},'%g');
    hl(nl)=sscanf(c{6},'%g');
    sl(nl)=sscanf(c{7},'%g');    
end
fclose(fi);

end

