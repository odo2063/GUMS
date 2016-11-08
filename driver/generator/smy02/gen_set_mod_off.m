function gen_set_mod_off(obj1)
hMainGui = getappdata(0,'hMainGUI');
obj1 = getappdata(hMainGui,'GenObj');

    gpib_write(obj1,'AM:OFF');


%idn='dummy generator'
end
