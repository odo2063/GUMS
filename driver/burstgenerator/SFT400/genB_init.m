function object = genB_init(adress)

#adress = fileread ('driver/burstgenerator/SFT400/std_address')

obj1=serial(adress, 600, 10)
set(obj1, "bytesize", 8)
set(obj1, "stopbits", 2)

%%%Initialisierung

% RESET

srl_write(obj1, char(160))

% Disconnect

fclose(obj1)



object = adress;
end
