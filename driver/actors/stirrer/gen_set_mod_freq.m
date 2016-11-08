function gen_set_mod_freq(freq)
hMainGui = getappdata(0,'hMainGUI');
obj1 = getappdata(hMainGui,'GenObj');

string = strcat({'AF '},{num2str(freq)});
fprintf(obj1,'%s',string{1});

%idn='dummy generator'
end