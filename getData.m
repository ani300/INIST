function [ data, data2,url] = getData(name,units,type,range)
%Mario Cano Diaz Code
    
    subsID=getID(name);
    url=getURL(subsID,units,type,range);
    data=downloadData(url,type);
    
    function [data]=downloadData(url,type)
        data=getTableFromWeb_mod(url,2);
        data2=0;
        if(strcmp(adaptText(type),adaptText('SatP')) || strcmp(adaptText(type),adaptText('SatT')))
        data2=getTableFromWeb_mod(url,3);
        end
    end
    function [url]=getURL(subsID,units,type,range)
        iniString='http://webbook.nist.gov/cgi/fluid.cgi?';
        RefState='RefState=DEF';
        actionString=strcat('Action=Load&Type=',type,'&');
        idString=strcat('ID=',subsID,'&');
        if(strcmp(adaptText(type),adaptText('isotherm')))
            type='IsoTherm';
            T=num2str(range(1));
            PLow=num2str(range(2));
            PInc=num2str(range(3));
            PHigh=num2str(range(4));
            Digits=num2str(range(5));
            varString=strcat(...
                'T=',T,'&',...
                'PLow=',PLow,'&',...
                'PHigh=',PHigh,'&',...
                'PInc=',PInc,'&',...
                'Digits=',Digits,'&');
        elseif(strcmp(adaptText(type),adaptText('isobar')))
            type='IsoBar';
            P=num2str(range(1));
            TLow=num2str(range(2));
            TInc=num2str(range(3));
            THigh=num2str(range(4));
            Digits=num2str(range(5));
            varString=strcat(...
                'P=',P,'&',...
                'TLow=',TLow,'&',...
                'THigh=',THigh,'&',...
                'TInc=',TInc,'&',...
                'Digits=',Digits,'&');
        elseif(strcmp(adaptText(type),adaptText('isochor')))
            type='IsoChor';
            D=num2str(range(1));
            TLow=num2str(range(2));
            TInc=num2str(range(3));
            THigh=num2str(range(4));
            Digits=num2str(range(5));
            varString=strcat(...
                'D=',D,'&',...
                'TLow=',TLow,'&',...
                'THigh=',THigh,'&',...
                'TInc=',TInc,'&',...
                'Digits=',Digits,'&');
        elseif(strcmp(adaptText(type),adaptText('satT')))
            type='SatP';
            TLow=num2str(range(1));
            TInc=num2str(range(2));
            THigh=num2str(range(3));
            Digits=num2str(range(4));
            varString=strcat(...
                'TLow=',TLow,'&',...
                'THigh=',THigh,'&',...
                'TInc=',TInc,'&',...
                'Digits=',Digits,'&');
        elseif(strcmp(adaptText(type),adaptText('satP')))
            type='SatT';
            PLow=num2str(range(1));
            PInc=num2str(range(2));
            PHigh=num2str(range(3));
            Digits=num2str(range(4));
            varString=strcat(...
                'PLow=',PLow,'&',...
                'PHigh=',PHigh,'&',...
                'PInc=',PInc,'&',...
                'Digits=',Digits,'&');
        else
            Error('Input Error');
        end
        if(strcmp(adaptText(units),adaptText('default'))) 
            TUnit='K';
            PUnit='bar';
            DUnit='kg%2Fm3';
            HUnit='kJ%2Fkg';
            WUnit='m%2Fs';
            VisUnit='uPa*s';
            STUnit='N%2Fm';
            
        else
            TUnit=units(1);
            PUnit=units(2);
            DUnit=units(3);
            HUnit=units(4);
            WUnit=units(5);
            VisUnit=units(6);
            STUnit=units(7);
        end
        unitString=strcat(...
                'TUnit=',TUnit,'&',...
                'PUnit=',PUnit,'&',...
                'DUnit=',DUnit,'&',...
                'HUnit=',HUnit,'&',...
                'WUnit=',WUnit,'&',...
                'VisUnit=',VisUnit,'&',...
                'STUnit=',STUnit,'&');
        actionString=strcat('Action=Load&Type=',type,'&');    
        url=strcat(iniString,varString,idString,actionString,unitString,RefState);
    end
    function [ ID_substance ] = getID( name_id )
    load('idList')
    found=false;
    index=0;
        while(~found)
            index=index+1;
            if(index==length(idList))
                ID_substance='Substance not Found';
                found=true;

            elseif(strcmp(adaptText(idList{index,2}),adaptText(name_id)))
                ID_substance=idList{index,1};
                found=true;
            elseif(strcmp(adaptText(idList{index,3}),adaptText(name_id)))
                ID_substance=idList{index,1};
                found=true;
            elseif(strcmp(adaptText(idList{index,4}),adaptText(name_id)))
                ID_substance=idList{index,1};
                found=true;
            end     
        end
    end
    function newText=adaptText(text)

                newText=lower(text);
                newText = strrep(newText, '?', 'a');
                newText = strrep(newText, '?', 'e');
                newText = strrep(newText, '?', 'i');
                newText = strrep(newText, '?', 'o');
                newText = strrep(newText, '?', 'u');
                newText = strrep(newText, '?', 'n');
                newText = strrep(newText, '?', 'c');

                newText = strrep(newText, '?', 'A');
                newText = strrep(newText, '?', 'E');
                newText = strrep(newText, '?', 'I');
                newText = strrep(newText, '?', 'O');
                newText = strrep(newText, '?', 'U');
                newText = strrep(newText, '?', 'N');
                newText = strrep(newText, '?', 'C');

                newText = strrep(newText, '?', 'a');
                newText = strrep(newText, '?', 'e');
                newText = strrep(newText, '?', 'i');
                newText = strrep(newText, '?', 'o');
                newText = strrep(newText, '?', 'u');

                newText = strrep(newText, '?',  'A'); 
                newText = strrep(newText, '?',  'E'); 
                newText = strrep(newText, '?',  'I'); 
                newText = strrep(newText, '?',  'O'); 
                newText = strrep(newText, '?',  'U'); 

                newText = strrep(newText, '?', 'a');
                newText = strrep(newText, '?', 'e');
                newText = strrep(newText, '?', 'i');
                newText = strrep(newText, '?', 'o');
                newText = strrep(newText, '?', 'u');

                newText = strrep(newText, '?',  'A'); 
                newText = strrep(newText, '?',  'E'); 
                newText = strrep(newText, '?',  'I'); 
                newText = strrep(newText, '?',  'O'); 
                newText = strrep(newText, '?',  'U'); 

                newText = strrep(newText, '?', 'a');
                newText = strrep(newText, '?', 'e');
                newText = strrep(newText, '?', 'i');
                newText = strrep(newText, '?', 'o');
                newText = strrep(newText, '?', 'u');

                newText = strrep(newText, '?',  'A'); 
                newText = strrep(newText, '?',  'E'); 
                newText = strrep(newText, '?',  'I'); 
                newText = strrep(newText, '?',  'O'); 
                newText = strrep(newText, '?',  'U'); 
        end

end

