function object = genB_setdur(adress,dur)

% Initialisierung

obj1=serial(adress, 600, 10);
set(obj1, "bytesize", 8);
set(obj1, "stopbits", 2);

% Translation

hex = "0x";
duration = cellstr(["0.75";"15"]);
bvalue = cellstr(["3E";"9F"]);

% cellidx ???

index = strcmp(duration, num2str(dur));
n = find (index, 1);

value = bvalue(n);

% Send RS232

srl_write(obj1, [char(0xB4) char(hex2dec(value))]);

% Disconnect

fclose(obj1);



object = adress;
end
