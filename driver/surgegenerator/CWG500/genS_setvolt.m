function object = genS_setvolt(adress,volt)

% Initialisierung

obj1=serial(adress, 600, 10)
set(obj1, "bytesize", 8)
set(obj1, "stopbits", 2)

% Translation

voltage = cellstr(["0.5";"1";"2";"4"]);
bvalue1 = cellstr(["0";"0";"0";"1"]);
bvalue2 = cellstr(["32";"64";"C8";"90"]);

% cellidx ???

index = strcmp(voltage, num2str(volt));
n = find (index, 1);

value1 = bvalue1(n);
value2 = bvalue2(n);

% Send RS232

srl_write(obj1, [char(0x78) char(hex2dec(value1)) char(hex2dec(value2))])
% Disconnect

fclose(obj1)



object = adress;
end
