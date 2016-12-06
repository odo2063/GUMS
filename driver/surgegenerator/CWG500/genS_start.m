function object = genS_start(adress,wait)

obj1=serial(adress, 600, 10);
set(obj1, "bytesize", 8);
set(obj1, "stopbits", 2);


% Charge

srl_write(obj1, [char(0x60)]);
sleep(wait)
% Trigger

srl_write(obj1, [char(0x63)]);

% Disconnect

fclose(obj1)



object = adress;
end
