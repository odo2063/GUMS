function object = act_init(adress)
% Find a GPIB object.
object = [];
obj1 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', adress, 'Tag', '');

% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = gpib('NI', 0, adress);
else
    fclose(obj1);
    obj1 = obj1(1)
end

% Connect to instrument object, obj1.
fopen(obj1);

% Communicating with instrument object, obj1.

idn = query(obj1, '*IDN?');

%idn = gen_get_idn;
id=strfind(idn,'SMY');

if (id==15)
  
    disp('SMY found!!!')
    %maxspeed=maximale geschwindigkeit setzen(Motor)
    fprintf(obj1,'Maxspeed:6') 
    pause(0.001)
    fprintf(obj1,'Minspeed:0.18')
    %acc=beschleunigung
    fprintf(obj1,'ACC:65')
    %dir=drehrichtung(1=uhrzeigersinn,0=gegen uhrzeigersinn)
    fprintf(obj1,'DIR:1')
    %init=müssen wir noch herausfinden
    fprintf(obj1,'INIT')
    
else
  
  disp('There is no SMY!!!')
  
  return

end

%%%Initialisierung

% RESET

fprintf(obj1,'*RST')

% OUTPUT OFF

fprintf(obj1,'LEVEL OFF')


object = obj1;
end