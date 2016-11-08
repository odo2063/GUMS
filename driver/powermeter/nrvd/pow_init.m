function object = pow_init(adress)

nrvd=gpib(adress,100);

% Communicating with instrument object, nrvd.

idn = gpib_read(nrvd, '*IDN?');

%idn = gen_get_idn;
id=strfind(idn,'NRVD');

if (id==15)
  
  disp('NRVD found!!!')

else
  
  disp('There is no NRVD!!!')
  
  return

end

%%%Initialisierung

## BEARBEITEN!!!
##ValueT = getappdata(hMainGui,'ValueType');
ValueT='DBUV';
% RESET

gpib_write(nrvd,'*RST; *CLS; *ESE 0, *SRE 0; STAT:PRESET')

% Testgenerator(50MHZ) aus

gpib_write(nrvd,'OUTP:ROSZ OFF')

%%f�r beide Kanäle

for channel=1:2

%Kanalwahl
st=strcat({'INP:NSEL '},{num2str(channel)});
gpib_write(nrvd,'%s',st{1})

%interne Frequenzkorrektur abschalten
gpib_write(nrvd,'SENS:CORR:FREF:STAT OFF')

%Messmodi auf AC
gpib_write(nrvd,'FUNC ''AC''')

%Einheit auf ValueT
ValueTstring=strcat({'AMPL:UNIT '},{ValueT})
gpib_write(nrvd,'%s',ValueTstring{1})

%Auflösung auf 'Meduium'
gpib_write(nrvd,'DISP:ANN:AMPL:RES ''MED''')

%ZEROing
gpib_write(nrvd,'CORR:ZERO:INIT')
pause(8);

end
object=nrvd;
end
