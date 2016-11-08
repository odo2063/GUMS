function gen_set_mod_depth(obj1,depth)

string = strcat({'AM '},{num2str(depth)});
gpib_write(obj1,'%s',string{1});
pause(0.0)
%idn='dummy generator'
end
