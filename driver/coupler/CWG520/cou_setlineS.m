function object = cou_setlineS(adress,B,S)

% Initialisierung

obj1=serial(adress, 600, 10);
set(obj1, "bytesize", 8);
set(obj1, "stopbits", 2);

% Translation

send = cellstr(["1";"2";"4";"8";"16"]);
line = cellstr(["001";"010";"011";"100";"101"]);

% cellidx ???

indexB = strcmp(send, num2str(B));
nB = find (indexB, 1);
valueB = line(nB);

indexS = strcmp(send, num2str(S));
nS = find (indexS, 1);
valueS = line(nS);

value = strcat("10",valueS,valueB);

% Send RS232

srl_write(obj1, [char(0x72) char(bin2dec(value))]);

% Disconnect

%fclose(obj1)



object = value;
end
