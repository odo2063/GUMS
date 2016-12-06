function genB_start(adress,number)

obj1=serial(adress, 600, 10);
set(obj1, "bytesize", 8);
set(obj1, "stopbits", 2);

hexvalue = dec2hex(number);
if length(hexvalue) = 1
hexvalue = strcat("0",hexvalue);
end
value = hexvalue;

% Start

srl_write(obj1, [char(0xBC) char(hex2dec(value))]);

% Disconnect

fclose(obj1)



object = adress;
end
