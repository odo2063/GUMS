function errorcode = gen_set_level(obj1,level)

## BEARBEITEN!!!
##ValueType = getappdata(hMainGui,'ValueType');
ValueType = 'V';


errorcode = 0;

%if strcmp(ValueType, 'DBUV') & level > 126
%    gen_set_output(0)
%    gen_adjust_amp
 %   waitfor(gen_adjust_amp)
  %  errorcode = 1;
%elseif strcmp(ValueType, 'DBM') & level > 19
 %   gen_set_output(0)
  %  gen_adjust_amp
   % waitfor(gen_adjust_amp)
    %errorcode = 1;
%elseif strcmp(ValueType, 'V') & level > 2
 %   gen_set_output(0)
  %  gen_adjust_amp
   % waitfor(gen_adjust_amp)
    %errorcode = 1;
%else
string = strcat({'VOLT '},{num2str(level)},{ValueType});
gpib_write(obj1,'%s',string{1});

##WTF???????
#string = strcat({'VOLT:UNIT '},{num2str(level)},{ValueType});
#gpib_write(obj1,'%s',string{1});

pause(0.2);
end
%idn='dummy generator'
