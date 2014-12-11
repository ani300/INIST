    function isob=getisobar(name,p,Tisobarmin,Tisobarmax)
        fprintf('Downloading %s isobar %f bar \n',name,p);
        [q3,~,url]=getData(name,'default','isobar',[p Tisobarmin (Tisobarmax-Tisobarmin)/201 Tisobarmax 12]);
        SZ2=size(q3,1)-1;
        if (SZ2==0) 
            error('uggg!!');
        end
        isob.P=p;
        isob.T=zeros(SZ2,1);
        isob.v=zeros(SZ2,1);
        isob.u=zeros(SZ2,1);
        isob.h=zeros(SZ2,1);
        isob.s=zeros(SZ2,1);

        for rr=2:SZ2+1
            pressure=sscanf(q3{rr,2},'%g');
            if (abs(pressure- p)>0.1) 
                fprintf('uhhh? pressure=%g and should be %g .. ignoring this point\n',pressure,p);
                continue;
            end
            isob.T(rr-1)=sscanf(q3{rr,1},'%g');
            isob.v(rr-1)=sscanf(q3{rr,4},'%g');
            isob.u(rr-1)=sscanf(q3{rr,5},'%g');
            isob.h(rr-1)=sscanf(q3{rr,6},'%g');
            isob.s(rr-1)=sscanf(q3{rr,7},'%g');
        end
        
    end
