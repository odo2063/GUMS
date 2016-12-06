function object = cou_set_surge(adress)

obj1=serial(adress, 600, 10);
set(obj1, "bytesize", 8)
set(obj1, "stopbits", 2)

%%%Initialisierung

% RESET

srl_write(obj1, char([0x70,0x20]))

fclose(obj1)

object = 0;#obj1;

end
