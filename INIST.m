function [ ret ] = INIST(varargin)
% INIST - 
% Interpolation of Nonideal Idiosyncratic Splendiferous Tables
% (c) Manel Soria - ETSIAT - UPC - 2014 A.D.
%
% Units: T(K), p(bar), h and u: kJ/kg, v: m^3/kg, s: kJ/kgK, MM: kg/mol
% 1st argument: substance properties
% 2nd and remaining arguments: 
%  critical temperature     'tcrit' 
%  critical pressure        'pcrit' 
%  critical volume          'vcrit' 
%  molecular mass           'MM'
%  saturation temperature   'tsat_p', p  
%  saturation pressure      'psat_t', T 
%  saturated liquid properties as a function of pressure
%     volume   'vl_p' , p 
%     energy   'ul_p' , p
%     enthalpy 'hl_p' , p
%     entropy  'sl_p' , p
%  saturated vapour properties as a function of pressure
%     volume   'vv_p' , p 
%     energy   'uv_p' , p
%     enthalpy 'hv_p' , p
%     entropy  'sv_p' , p
%  saturated liquid properties as a function of temperature
%     volume   'vl_t' , t 
%     energy   'ul_t' , t
%     enthalpy 'hl_t' , t
%     entropy  'sl_t' , t
%  saturated vapour properties as a function of temperature
%     volume   'vv_t' , t 
%     energy   'uv_t' , t
%     enthalpy 'hv_t' , t
%     entropy  'sv_t' , t
%  non-saturated properties as a function of pressure and temperature
%     volume   'v_pt' , p , t
%     energy   'u_pt' , p , t
%     enthaply 'h_pt' , p , t
%     entrophy 's_pt' , p , t
%  temperature as a function of ...
%     pressure and entropy 't_ps', p ,s  
%     
%  special functions:
%               'minp'        returns the minimum isobar available
%               'maxp'        idem max isobar
%               'mint'        idem minimum temperature 
%               'maxt'        idem maximum temperature 
%               'isobars'     returns a vector with the available isobars
%               'add_p' , p   downloads and stores a new isobar. Returns
%                             new data. Example:
%                             dat=INIST(dat,'add_p',33);
% 

dat=varargin{1};
prop=varargin{2};

switch lower(prop)
    case 'mm'
        ret=dat.MM;
    case 'tcrit'
        ret=dat.Tsat(end);
    case 'pcrit'
        ret=dat.Psat(end);
    case 'vcrit'
        ret=dat.vl(end);
    case 'isobars'
        ret=[];
        for i=1:length(dat.isoP)
            ret(i)=dat.isoP{i}.P;
        end
    case 'tsat_p' 
        p=varargin{3};
        check_satp(p);
        ret = interp1(dat.Psat,dat.Tsat,p);
    case 'psat_t'
        T=varargin{3};
        check_satT(T);
        ret = interp1(dat.Tsat,dat.Psat,T);        
    
    case 'vl_p', p=varargin{3}; check_satp(p);ret=interp1(dat.Psat,dat.vl,p);        
    case 'ul_p', p=varargin{3}; check_satp(p);ret=interp1(dat.Psat,dat.ul,p);
    case 'hl_p', p=varargin{3}; check_satp(p);ret=interp1(dat.Psat,dat.hl,p);
    case 'sl_p', p=varargin{3}; check_satp(p);ret=interp1(dat.Psat,dat.sl,p);

    case 'vv_p', p=varargin{3}; check_satp(p);ret=interp1(dat.Psat,dat.vv,p);        
    case 'uv_p', p=varargin{3}; check_satp(p);ret=interp1(dat.Psat,dat.uv,p);
    case 'hv_p', p=varargin{3}; check_satp(p);ret=interp1(dat.Psat,dat.hv,p);
    case 'sv_p', p=varargin{3}; check_satp(p);ret=interp1(dat.Psat,dat.sv,p);
        
        
    case 'vl_t', t=varargin{3}; check_satT(t);ret=interp1(dat.Tsat,dat.vl,t);        
    case 'ul_t', t=varargin{3}; check_satT(t);ret=interp1(dat.Tsat,dat.ul,t);
    case 'hl_t', t=varargin{3}; check_satT(t);ret=interp1(dat.Tsat,dat.hl,t);
    case 'sl_t', t=varargin{3}; check_satT(t);ret=interp1(dat.Tsat,dat.sl,t);

    case 'vv_t', t=varargin{3}; check_satT(t);ret=interp1(dat.Tsat,dat.vv,t);        
    case 'uv_t', t=varargin{3}; check_satT(t);ret=interp1(dat.Tsat,dat.uv,t);
    case 'hv_t', t=varargin{3}; check_satT(t);ret=interp1(dat.Tsat,dat.hv,t);
    case 'sv_t', t=varargin{3}; check_satT(t);ret=interp1(dat.Tsat,dat.sv,t);
        
    case {'v_pt','u_pt','h_pt','s_pt'}
        p=varargin{3}; 
        T=varargin{4}; 
        checkp(p); 
        checkT(T); 
        checkpT(p,T);
        p1=findp(p);
        
        switch prop(1)
            case 'v', val1=myi(dat.isoP{p1}.T,dat.isoP{p1}.v,T); val2=myi(dat.isoP{p1+1}.T,dat.isoP{p1+1}.v,T); 
            case 'u', val1=myi(dat.isoP{p1}.T,dat.isoP{p1}.u,T); val2=myi(dat.isoP{p1+1}.T,dat.isoP{p1+1}.u,T); 
            case 'h', val1=myi(dat.isoP{p1}.T,dat.isoP{p1}.h,T); val2=myi(dat.isoP{p1+1}.T,dat.isoP{p1+1}.h,T);
            case 's', val1=myi(dat.isoP{p1}.T,dat.isoP{p1}.s,T); val2=myi(dat.isoP{p1+1}.T,dat.isoP{p1+1}.s,T);
                
        end
        ret=interp1([dat.isoP{p1}.P dat.isoP{p1+1}.P],[val1 val2],p);
    case 't_ps'
        p=varargin{3}; 
        s=varargin{4};
        checkp(p);
        if (p<dat.Pcrit) 
            sl=INIST(dat,'sl_p',p);
            sv=INIST(dat,'sv_p',p);
            tsat=INIST(dat,'tsat_p',p);
            if s>=sl && s<=sv 
                ret=tsat;
            else
                eq=@(x) INIST(dat,'s_pt',p,x)-s;
                options=optimset('Display','none');
                ret=fsolve(eq,tsat,options);
            end
        else
            eq=@(x) INIST(dat,'s_pt',p,x)-s;
            options=optimset('Display','none');
            ret=fsolve(eq,dat.Tcrit*1.1,options);
        end
    case 'add_p'
        p=varargin{3};
        if p>=dat.isoP{end}.P || p<=dat.isoP{1}.P
            error(sprintf('p=%g outside current range of isobars',p));
        end
        p1=findp(p);
        if abs(dat.isoP{p1}.P-p)<1e-4 || ...
           abs(dat.isoP{p1+1}.P-p)<1e-4  % don't add a pressure too close to a current isobar
            fprintf('p=%f is too close to a current isobar\n',p);
        else
            newp=getisobar(dat.name,p,dat.Tisobarmin,dat.Tisobarmax);        
            ll=length(dat.isoP);
            for indx=ll:-1:p1+1
                dat.isoP{indx+1}=dat.isoP{indx};
            end
            dat.isoP{p1}=newp;            
        end
        ret=dat;
    case 'minp'
        ret=dat.isoP{1}.P;
    case 'maxp'
        ret=dat.isoP{end}.P;
    case 'mint'
        ret=dat.isoP{1}.T(1);
    case 'maxt'
        ret=dat.isoP{1}.T(end);
    otherwise
        error('INIST: unknown function');
end


    function check_satp(p) 
        if p<dat.Psat(1)            
            error(sprintf('uhh? p=%e bar is too low, min sat. pressure for %s is %e bar',p,dat.name,dat.Psat(1)));
        end
        if (p>dat.Psat(end))
            error(sprintf('uhh? p=%e bar is above %s critical pressure=%e bar',p,dat.name,dat.Psat(end)));
        end
    end

    function check_satT(T) 
        if T<dat.Tsat(1)            
            error(sprintf('uhh? T=%e K is too low, min sat. temp. for %s is %e K',T,dat.name,dat.Tsat(1)));
        end
        if (T>dat.Tsat(end))
            error(sprintf('uhh? T=%e K is above %s critical pressure=%e K',T,dat.name,dat.Tsat(end)));
        end
    end

    function checkp(p)
        if (p<dat.isoP{1}.P || p>dat.isoP{end}.P)
            error('uhh? P out of range');
        end
    end 

    function checkT(T)
        if (T<dat.isoP{1}.T(1) || T>dat.isoP{1}.T(end))
            error(sprintf('uhh? T=%e out of range of %s temperatures (%e to %e)',T,dat.name,dat.isoP{1}.T(1),dat.isoP{1}.T(end)));
        end
    end 

    function checkpT(P,T) 
        checkp(P);
        checkT(T);
        % Now, we will check that P and T don't match saturation conditions
        if (P>dat.Psat(end)) % supercritical
            return;
        end
        if (T>dat.Tsat(end)) % supercritical
            return;
        end
        
        if ( T<=dat.Tsat(end) )
            Psat=INIST(varargin{1},'Psat_t',T);
            if Psat==P
                error('saturation !');
            end
        end
    end 

    function i=findp(p)
        for i=1:length(dat.isoP)
            if p >= dat.isoP{i}.P && p < dat.isoP{i+1}.P
                %fprintf('asked for p=%f, found between p=%f and p=%f \n',p,dat.isoP{i}.P,dat.isoP{i+1}.P);
                return
            end
        end
        error('Outside Splendiferous Pressure Range !');
    end

    function y=myi(X,Y,x) % interpolates avoiding l-v phase change singularity
        if x<X(1)
            error('Too low: Splendiferous error');
        end
        if x>X(end)
            error('Too high: Splendiferous error');
        end        
        q=find(diff(X)==0);
        if isempty(q) 
            y=interp1(X,Y,x);
            return
        end    
        if (x<=X(q))
            y=interp1(X(1:q),Y(1:q),x);
        else
            y=interp1(X(q+1:end),Y(q+1:end),x);
        end
    end

end

