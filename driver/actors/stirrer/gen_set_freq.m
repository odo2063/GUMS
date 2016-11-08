function gen_set_freq(freq)
hMainGui = getappdata(0,'hMainGUI');
obj1 = getappdata(hMainGui,'GenObj');

string = strcat({'RF '},{num2str(freq)});
fprintf(obj1,'%s',string{1});

%idn='dummy generator'
end