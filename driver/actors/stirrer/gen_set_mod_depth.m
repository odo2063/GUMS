function gen_set_mod_depth(depth)
hMainGui = getappdata(0,'hMainGUI');
obj1 = getappdata(hMainGui,'GenObj');

string = strcat({'AM '},{num2str(depth)});
fprintf(obj1,'%s',string{1});
pause(0.0)
%idn='dummy generator'
end