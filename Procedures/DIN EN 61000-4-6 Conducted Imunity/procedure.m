function data = procedure(f_start,f_stop,leveltol,t_dwell,t_wait,mod_freq,mod_depth)

f_table,levels = level!!!!!!!!!!!!!!

semilogx(f_table, levels,'g', f_table, levels-leveltol,'r', f_table, levels+leveltol,'r')
 axis([min(f_table) max(f_table) min(levels)-3 max(levels)+3])
 grid('minor')
 xlabel('frequency in Hz')
 ylabel('reached level in dBµV')
 hold on;
 %axis([f_start f_stop level-3 level+3])
 
pre_level = 33; %dBµV
gen_error=gen_set_level(pre_level);

#####hMainGui = getappdata(0,'hMainGUI');

%f_table = find_f_table(f_table_norm,f_start,f_stop);

######!!!!!!!!!!!1calfile = getappdata(hMainGui,'calfile');
######!!!!!!!!!!!status_setup = getappdata(hMainGui,'status_setup');
[gen_level,calvalue] = find_cal_data(calfile,f_table);


######set(handles.status_freq,'Visible','on')
######set(handles.status_level,'Visible','on')
pow_set_channel(1);
gen_error=gen_set_level(33)
gen_set_output(1)
errorcode = 0;
gen_error = 0;
if status_setup ~= 1
    %%% SETUP Phase
    gen_set_output(1)
    gen_set_mod_off
    
    ######set(handles.status_wait,'BackgroundColor','cyan')

    ######set(handles.status_setup,'BackgroundColor','yellow')
    l=1;
    while l<=length(f_table)
    
        if f_table(l) > 1e6
            ######-> zeige werte in popup     set(handles.status_freq,'String',strcat(num2str(f_table(l)/1e6),' MHz'))
        elseif f_table(l) > 1e3
            ######set(handles.status_freq,'String',strcat(num2str(f_table(l)/1000),' kHz'))
        else
            ######set(handles.status_freq,'String',strcat(num2str(f_table(l)),' Hz'))
        end
    #####pause(0.001)
    gen_set_freq(f_table(l));

    
    
    if l == 1 
        pre_level = gen_level(l)
        gen_set_level(pre_level)
    end
    cal = calvalue(l);
    [r_level, pre_level,gen_error] = power_up(handles!!!!!!!!!!!!,levels(l),pre_level,leveltol,cal);
    #######set(handles.status_level,'String',strcat(num2str(r_level),' dBµV'))
    
    if gen_error ~= 0
        l=0
    else
        
    setup_data(l)=pre_level
    setup_r_level(l)=r_level;
    semilogx(f_table(1:l),setup_r_level(1:l),'b')
    
       #######-> check was in popup gedrückt IRQ = getappdata(hMainGui,'IRQ');
    
    errorcode = 0;
    
    if IRQ == 1
        #setappdata(hMainGui,'index', l)
        #setappdata(hMainGui,'ftable', f_table)
        #setappdata(hMainGui,'gen_level', setup_data(l))
        #setappdata(hMainGui,'r_level', r_level)
        #setappdata(hMainGui,'cal_value', calvalue)
        #setappdata(hMainGui,'mod_depth', mod_depth)
        
        
        
        errorcode = 1;
        %setappdata(hMainGui,'IRQ', 0)
        display('manualmode')
        #setappdata(hMainGui,'status_setup',2);
        break
        %manual
        %waitfor(manual)
        %l = getappdata(hMainGui,'index');
        %r_level = getappdata(hMainGui,'r_level');
        %IRQ = getappdata(hMainGui,'IRQ');
        if IRQ == 1
            
            data(l,:)=[f_table(l),levels(l),r_level,errorcode];
            break
        end
    end
    end
    
    
    #####pause(0.001)
%     %%% TEST FOR CORRECTNESS
%     pow_set_channel(2);
%     errorcode=pow_get_value + 15.6
%     pow_set_channel(1)
%     %%%
    %pause(t_dwell)
    l=l+1;
    end
    #setappdata(hMainGui,'setup_data',setup_data);
    #setappdata(hMainGui,'setup_r_level',setup_r_level);
    
    #if getappdata(hMainGui,'status_setup') ~= 2
    #    setappdata(hMainGui,'status_setup',1);
    end
    gen_error=gen_set_level(pre_level-6)
else
    #setup_data = getappdata(hMainGui,'setup_data');
    #setup_r_level = getappdata(hMainGui,'setup_r_level');
    gen_error=gen_set_level(setup_data(1)-6)
end
   
    %%%MEASURE Phase
    inc=0;
    l=1;
    while l <= length(f_table)
    
    ####set(handles.status_setup,'BackgroundColor','cyan')
    ####set(handles.status_meas,'BackgroundColor','yellow')
    ####pause(0.001)
    
    if f_table(l) > 1e6
        ####set(handles.status_freq,'String',strcat(num2str(f_table(l)/1e6),' MHz'))
    elseif f_table(l) > 1e3
        ####set(handles.status_freq,'String',strcat(num2str(f_table(l)/1000),' kHz'))
    else
        ####set(handles.status_freq,'String',strcat(num2str(f_table(l)),' Hz'))
    end
    
    gen_set_freq(f_table(l));
    gen_set_level_inc(inc);
%     if l > 1
%         gen_set_level_inc(setup_data(l)-setup_data(l-1));
%     else
    setup_data(l)
        gen_set_level(setup_data(l))
%     end
    r_level=setup_r_level(l);
    ####popup    set(handles.status_level,'String',strcat(num2str(r_level),' dBµV'))
    
    pause(0.001)
    
    if t_dwell > 0
    %tic
    gen_set_mod_freq(mod_freq)
    %toc
    gen_set_mod_depth(mod_depth)
    %toc
    %waitfor()
    %toc
    pause(t_dwell)
    %toc
   
    end
    
    %%% WAIT Phase
    
   
    
    if t_wait > 0
        ####set(handles.status_meas,'BackgroundColor','cyan')
        ####set(handles.status_wait,'BackgroundColor','yellow')
        pause(0.001)
        ####set(handles.status_level,'String',strcat(num2str(setup_data(l)-6),' dBµV'))
        gen_set_level_inc(-6)
        pause(t_wait)
        gen_set_level_inc(6)
    end
    
    ####popup IRQ = getappdata(hMainGui,'IRQ');
    
    errorcode = 0;
    
    pow_set_channel(1)
    if IRQ == 1
        #setappdata(hMainGui,'index', l)
        #setappdata(hMainGui,'ftable', f_table)
        #setappdata(hMainGui,'gen_level', setup_data(l))
        #setappdata(hMainGui,'r_level', r_level)
        #setappdata(hMainGui,'cal_value', calvalue)
        #setappdata(hMainGui,'mod_depth', mod_depth)
        
        
        
        errorcode = 1;
        #setappdata(hMainGui,'IRQ', 0)
        ##display('manualmode')
        %%break
        
        ##manual
        ##waitfor(manual)
        ##gen_set_mod_depth(mod_depth)
        ##gen_set_output(1)
        ##l = getappdata(hMainGui,'index');
        ##r_level = getappdata(hMainGui,'r_level');
        ##IRQ = getappdata(hMainGui,'IRQ');
        if IRQ == 1
            
            data(l,:)=[f_table(l),levels(l),r_level,errorcode];
            break
        end
    end
    
%     %%% TEST FOR CORRECTNESS
%     pow_set_channel(2);
%     errorcode=pow_get_value + 15.6
%     pow_set_channel(1);
%     %%%
    
    data(l,:)=[f_table(l),levels(l),r_level,errorcode]; %vllt r_level
    
    ##set(handles.status_setup,'BackgroundColor','cyan')
    ##set(handles.status_meas,'BackgroundColor','cyan')
    ##set(handles.status_wait,'BackgroundColor','cyan')
    
    semilogx(data(:,1),data(:,2),'b','linewidth',2)
    pause(0.001)
%     if errorcode > 0
%         semilogx(data(end,1),data(end,2),'*','r')
%     end
    gen_set_level_inc(inc*-1)
    l=l+1;
    end
    
    ##set(handles.status_setup,'BackgroundColor','cyan')
    ##set(handles.status_meas,'BackgroundColor','cyan')
    ##set(handles.status_wait,'BackgroundColor','cyan') 
gen_set_mod_off
gen_set_output(0)
hold off
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

function [gen_level,calvalue] = find_cal_data(calfile,f_table)
caldata=csvread(calfile,2);
calvalue = interp1(caldata(:,1),caldata(:,2),f_table);
gen_level = interp1(caldata(:,1),caldata(:,3),f_table);
end

function [r_level, pre_level,gen_error] = power_up(handles!!!!!!!!!!,level, pre_level,leveltol,cal)
display('powerup')
gen_error = 0;
%d = -100

value = pow_get_value
r_level = value - cal
d = r_level -level

while d < 0 | d > leveltol

    

    e=d; 
    %if e > leveltol || e < 0
        if abs(e) < 0.1 & e > 0
            pre_level = pre_level - 0.1
        elseif abs(e) < 0.1 & e < 0
            pre_level = pre_level + 0.1
        %elseif abs(e) > 7
        %   pre_level = pre_level - e*1.1
        else
            pre_level = pre_level - e
        end
    %end
    display(pre_level)
    gen_error = gen_set_level(pre_level);
    
    if gen_error ~= 0
        break
    end
    
    
    value = pow_get_value;
    
    display(cal)
    d = value -level - cal;
    r_level = value - cal;
    %set(handles.status_level,'String',strcat(num2str(r_level),' dBµV'))  
    
end

%display(value)
%display(r_level)
########set(handles.status_level,'String',strcat(num2str(r_level),' dBµV'))

end
