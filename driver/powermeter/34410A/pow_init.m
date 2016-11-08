function object = pow_init(adress)
% Find a GPIB object.


% Connect to instrument object, nrvd.
nrvd=gpib(adress,100);

% Communicating with instrument object, nrvd.

idn = gpib_read(nrvd, '*IDN?');

%idn = gen_get_idn;
id=strfind(idn,'34410A');

if (id==22)
  
  disp('Agilent found!!!')

else
  
  disp('There is no Agilent!!!')
  
  return

end

%%%Initialisierung

% RESET

gpib_write(nrvd,'*RST')
gpib_write(nrvd,'*CLS')
gpib_write(nrvd,'*ESE 0')
gpib_write(nrvd,'*SRE 0')
gpib_write(nrvd,'SYST:PRES')
gpib_write(nrvd,'CONF:VOLT:AC')


object=nrvd;
end
