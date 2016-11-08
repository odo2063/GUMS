function errorcode = gen_set_level(obj1,level)
##NOCH ZU BEARBEITEN
##ValueType = getappdata(hMainGui,'ValueType');
ValueType='DBUV';

errorcode = 0

if strcmp(ValueType, 'DBUV') & level > 126
    smy02_gen_set_output(obj1,0)
    smy02_gen_adjust_amp
    waitfor(smy02_gen_adjust_amp)
    errorcode = 1;
elseif strcmp(ValueType, 'DBM') & level > 0
    smy02_gen_set_output(obj1,0)
    smy02_gen_adjust_amp
    waitfor(smy02_gen_adjust_amp)
    errorcode = 1;
elseif strcmp(ValueType, 'V') & level > 2
    smy02_gen_set_output(obj1,0)
    smy02_gen_adjust_amp
    waitfor(smy02_gen_adjust_amp)
    errorcode = 1;
else
string = strcat({'LEVEL '},{num2str(level)},{ValueType});
gpib_write(obj1,'%s',string{1});
pause(0.2);
end
%idn='dummy generator'
end
