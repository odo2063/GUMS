function gen_set_freq(obj1,freq)

string = strcat({'FREQ '},{num2str(freq)});
gpib_write(obj1,'%s',string{1});

%idn='dummy generator'
end
