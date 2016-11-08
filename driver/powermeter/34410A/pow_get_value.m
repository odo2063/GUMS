function value = pow_get_value(obj1)

value = str2double(gpib_read(obj1, 'READ?'));

%pause(0.1);
%idn='dummy generator'
end
