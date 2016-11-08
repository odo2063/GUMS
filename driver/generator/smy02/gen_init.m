function object = gen_init(adress)

obj1=gpib(adress,100);

% Communicating with instrument object, obj1.

idn = gpib_read(obj1, '*IDN?');

%idn = gen_get_idn;
id=strfind(idn,'SMY');

if (id==15)
  
  disp('SMY found!!!')


else
  
  disp('There is no SMY!!!')
  
  return

end

%%%Initialisierung

% RESET

gpib_write(obj1,'*RST')

% OUTPUT OFF

gpib_write(obj1,'LEVEL OFF')


object = obj1;
end
