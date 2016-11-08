## Noch finale Anpassung, Fenster fr Infos und Stop(/Abbrechen)

function data = procedure(f_start,f_stop,level,leveltol,coupler_value,GenAdr,PowAdr)

#gen_adjust_amp
f_start=str2num(f_start)
f_stop=str2num(f_stop)
level=str2num(level)
leveltol=str2num(leveltol)
coupler_value=str2num(coupler_value)





GenObj=gen_init_fast(str2num(GenAdr))
PowObj=pow_init_fast(str2num(PowAdr))

data=[];

f=f_start;
l=1;

while (f<f_stop)
f_table_norm(l)=f;
f=f*1.01;
l=l+1;
end






semilogx([f_start f_stop], [0 0],'g')
 axis([f_start f_stop level-3 level+3])
 grid('minor')
 xlabel('frequency in Hz')
 ylabel('calibration value in dB')
 hold on;
 axis([f_start f_stop -20 5])
 
pre_level = 33.333; %dBV
gen_error=gen_set_level(GenObj,pre_level);

f_table = f_table_norm;#find_f_table(f_table_norm,f_start,f_stop);

pow_set_channel(PowObj,2);

l = 1;
while (l <= length(f_table))

    %%% SETUP Phase
    
    gen_set_freq(GenObj,f_table(l));

    gen_set_output(GenObj,1);
    
    
    [out_level, pre_level, gen_error] = power_up(level,pre_level,leveltol,coupler_value,GenObj,PowObj);
    
    if (gen_error ~= 0)
        l = 0;
        gen_error = 0;
        pre_level = 33.33;
    else

    %pause(t_dwell)

    %%%MEASURE Phase
    
    pow_set_channel(PowObj,1);
    in_level = pow_get_value(PowObj);
    cal_value = in_level - out_level;
    pow_set_channel(PowObj,2);
    
    %%% WAIT Phase
    
    ##IRQ = getappdata(hMainGui,'IRQ');
    IRQ=0;
    %errorcode = 0;
    
    if (IRQ == 1)
        %errorcode = 1;
        #setappdata(hMainGui,'IRQ', 0)
        display('manualmode')
        %%break
        #manual
        #waitfor(manual)
##        IRQ = getappdata(hMainGui,'IRQ');
        if (IRQ == 1)
##           set(handles.status_setup,'BackgroundColor','cyan')
##            set(handles.status_meas,'BackgroundColor','cyan')
            
            break
        end
    end
    
    
    
    data(l,:)=[f_table(l),cal_value(1),pre_level(1),in_level(1),out_level(1)]; %vllt r_level
    
    
    %semilogx(data(:,1),data(:,2),'b','linewidth',2)
    #update_display(data,out_level,f_table(l))
	semilogx(data(:,1),data(:,2),'b','linewidth',2);    
	pause(0.001)
    end
    l = l + 1;
end
gen_set_output(GenObj,0);
hold off


create_report(data);
end

function f_table = find_f_table(f_table_norm,f_start,f_stop)
table=(f_table_norm-f_start);
for i=1:length(table)
    if table(i) <= 0
        table(i) = 1;
    else
        table(i) = 0;
    end
end
i_start=find(table);
i_start=i_start(end);

table=(f_table_norm-f_stop);
for i=1:length(table)
    if table(i) >= 0
        table(i) = 1;
    else
        table(i) = 0;
    end
end
i_stop=find(table);
i_stop=i_stop(1);

f_table=f_table_norm(i_start:i_stop);
end
#display('before')
function [r_level, pre_level, gen_error] = power_up(level, pre_level,leveltol,coupler_value,GenObj,PowObj)
#display('powerup')
%d = -100

gen_error=0;
value = pow_get_value(PowObj);
r_level = value - coupler_value; %+ cal;
d = r_level - level; %+cal

while (d < 0 || d > leveltol)

    

    f=d;
    %if f > leveltol || f < 0
        if (abs(f) < 0.1 && f > 0)
            pre_level = pre_level - 0.1;
        elseif (abs(f) < 0.1 && f < 0)
            pre_level = pre_level + 0.1;
        elseif (abs(f) > 7)
            pre_level = pre_level - f*1.1;
        else
            pre_level = pre_level + 1;#(f)
        end
    %end
    gen_error = gen_set_level(GenObj,pre_level(1));
    if (gen_error ~= 0)
        break
    end
    value = pow_get_value(PowObj);
    
    
    r_level = value - coupler_value; %+ cal;
    d = r_level - level; %+ cal
    
end

#display(r_level)

end

function update_display(data, out_level, freq)
 #if freq > 1e6
 #       set(handles.status_freq,'String',strcat(num2str(freq/1000),' MHz'))
 #   elseif freq > 1e3
 #       set(handles.status_freq,'String',strcat(num2str(freq/1000),' kHz'))
 #   else
 #       set(handles.status_freq,'String',strcat(num2str(freq),' Hz'))
 #end
 #   set(handles.status_level,'String',strcat(num2str(out_level),' dBV'))
    semilogx(data(:,1),data(:,2),'b','linewidth',2)
end
