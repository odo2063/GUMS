function object = cou_setlineB(adress,B)

% Initialisierung

obj1=serial(adress, 600, 10)
set(obj1, "bytesize", 8)
set(obj1, "stopbits", 2)

% Translation
%x = str2num(B);
burst = B + 128;
value = dec2hex(burst);

% Send RS232

srl_write(obj1, [char(0xB2) char(hex2dec(value))])

% Disconnect

%fclose(obj1)



object = value;
end
