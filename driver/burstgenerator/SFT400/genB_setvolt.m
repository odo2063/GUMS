function object = genB_setvolt(adress,volt)

% Initialisierung

obj1=serial(adress, 600, 10);
set(obj1, "bytesize", 8);
set(obj1, "stopbits", 2);

% Translation

hex = "0x";
voltage = cellstr(["0.25";"0.5";"1";"2";"4"]);
bvalue  = cellstr(["05";"1E";"50";"82";"E6"]);

% cellidx ???

index = strcmp(voltage, num2str(volt));
n = find (index, 1);

value = bvalue(n);

% Send RS232

srl_write(obj1, [char(0xB6) char(hex2dec(value))])

% Disconnect

%fclose(obj1)



object = value;
end
