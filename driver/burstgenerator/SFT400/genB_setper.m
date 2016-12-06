function object = genB_setper(adress,per)

% Initialisierung

obj1=serial(adress, 600, 10)
set(obj1, "bytesize", 8)
set(obj1, "stopbits", 2)

% Translation

hex = "0x";
period = cellstr(["300"]);
bvalue = cellstr(["69"]);

% cellidx ???

index = strcmp(period, num2str(per));
n = find (index, 1);

value = bvalue(n);

% Send RS232

srl_write(obj1, [char(0xB5) char(hex2dec(value))])

% Disconnect

fclose(obj1)



object = adress;
end
