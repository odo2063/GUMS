function gen_set_level_inc(obj1,level)

if level > 0.1 | level < -0.1
if log10(level) >= 2
    x=2
elseif log10(level) >= 1
    x=1
elseif log10(level) > 0
    x=0
else
    x=-1
end
string = strcat({'LEVEL:VAR '},{'1e'},{num2str(x)})%,{' DBUV'})
gpib_write(obj1,'%s',string{1})

string= strcat('1e',num2str(x))
lev=level/str2double(string)

for i=1:round(abs(lev))
if level > 0
    gpib_write(obj1,'INCREMENT:LEVEL')
else
    gpib_write(obj1,'DECREMENT:LEVEL')
end
end
pause(0.2);
%idn='dummy generator'
end
end
