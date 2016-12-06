function object = genB_setfreq(adress,freq)

% Initialisierung

obj1=serial(adress, 600, 10);
set(obj1, "bytesize", 8);
set(obj1, "stopbits", 2);

% Translation

hex = "0x";
frequenz = cellstr(["5";"100"]);
bvalue = cellstr(["31";"BA"]);

% cellidx ???

index = strcmp(frequenz, num2str(freq));
n = find (index, 1);

value = bvalue(n);

% Send RS232

srl_write(obj1, [char(0xB3) char(hex2dec(value))])

% Disconnect

fclose(obj1)



object = adress;
end
