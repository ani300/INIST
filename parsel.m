function dat=parsel(name,Psatmin,Psatmax,Tisobarmin,Tisobarmax,Isobarmax,np1,np2,MM)

Isobarmin=Psatmin;

dat.Tisobarmin=Tisobarmin;
dat.Tisobarmax=Tisobarmax;

% saturation properties
%
fprintf('Downloading %s saturation properties \n',name);
[q1,q2,url]=getData(name,'default','satP',[Psatmin (Psatmax-Psatmin)/201 Psatmax 12]);

SZ=size(q1,1)-1;
if (SZ==0) 
        error('uggg!!');
end

dat.Tsat=zeros(SZ,1);
dat.Psat=zeros(SZ,1);
dat.vl=zeros(SZ,1);
dat.ul=zeros(SZ,1);
dat.hl=zeros(SZ,1);
dat.sl=zeros(SZ,1);
dat.vv=zeros(SZ,1);
dat.uv=zeros(SZ,1);
dat.hv=zeros(SZ,1);
dat.sv=zeros(SZ,1);
for r=2:SZ+1
    dat.Tsat(r-1)=sscanf(q1{r,1},'%g');
    dat.Psat(r-1)=sscanf(q1{r,2},'%g');
    dat.vl(r-1)=sscanf(q1{r,4},'%g');
    dat.ul(r-1)=sscanf(q1{r,5},'%g');    
    dat.hl(r-1)=sscanf(q1{r,6},'%g');
    dat.sl(r-1)=sscanf(q1{r,7},'%g');    
    dat.vv(r-1)=sscanf(q2{r,4},'%g');
    dat.uv(r-1)=sscanf(q2{r,5},'%g');    
    dat.hv(r-1)=sscanf(q2{r,6},'%g');
    dat.sv(r-1)=sscanf(q2{r,7},'%g');    
end

%

% Isobaric properties

dat.isoP={};

%
%subcrit_p=linspace(Isobarmin,Psatmax,np1);
subcrit_p=logspace(log10(Isobarmin),log10(Psatmax),np1);
for i=1:length(subcrit_p)
    isob=getisobar(name,subcrit_p(i),dat.Tisobarmin,dat.Tisobarmax);
    dat.isoP{end+1}=isob;    
end
 %

%supcrit_p=linspace(Psatmax,Isobarmax,np2+1);
supcrit_p=logspace(log10(Psatmax),log10(Isobarmax),np2);
for i=2:length(supcrit_p)
    isob=getisobar(name,supcrit_p(i),dat.Tisobarmin,dat.Tisobarmax);
    dat.isoP{end+1}=isob;    
end


% fluid properties
dat.name=name;
dat.Pcrit=Psatmax;
dat.Tcrit=dat.Tsat(end);
dat.MM=MM;

fprintf('Done %s ... pausing 10 minutes \n',name);

pause(60*10); 


end



