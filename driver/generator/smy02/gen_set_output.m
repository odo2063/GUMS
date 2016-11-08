function gen_set_output(obj1,status)

if status == 1
    gpib_write(obj1,'LEVEL ON');
elseif status == 0
    gpib_write(obj1,'LEVEL OFF');
else
    display('Input MUST be 1 for ON and 0 for OFF')
end

end
