function object = gen_init(adress)
% Find a GPIB object.


% Connect to instrument object, obj1.
obj1=gpib_read(adress,100);

% Communicating with instrument object, obj1.

idn = gpib_read(obj1, '*IDN?');

%idn = gen_get_idn;
id=strfind(idn,'33120A');

if (id==17)
  
  disp('33120A found!!!')


else
  
  disp('There is no HP!!!')
  
  return

end

%%%Initialisierung

% RESET

gpib_write(obj1,'*RST')

% OUTPUT OFF

%fprintf(obj1,'LEVEL OFF')


object = obj1;
end
