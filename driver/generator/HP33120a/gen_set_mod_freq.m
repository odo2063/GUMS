function gen_set_mod_freq(obj1,freq)

string = strcat({'AF '},{num2str(freq)});
gpib_write(obj1,'%s',string{1});

%idn='dummy generator'
end
