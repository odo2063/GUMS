function object = genS_setphas(adress,phas)

% Initialisierung

obj1=serial(adress, 600, 10)
set(obj1, "bytesize", 8)
set(obj1, "stopbits", 2)

% Translation

phase = cellstr(["0";"90";"180";"270"]);
svalue1 = cellstr(["00";"00";"00";"01"]);
svalue2 = cellstr(["00";"5A";"B4";"0E"]);

% cellidx ???

index = strcmp(phase, num2str(phas));
n = find (index, 1);

value1 = svalue1(n);
value2 = svalue2(n);

% Send RS232

srl_write(obj1, [char(0x79) char(hex2dec(value1)) char(hex2dec(value2))])

% Disconnect

fclose(obj1)



object = adress;
end
