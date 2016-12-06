function path = sysload(a,x)
y = str2num(x);
y=y+1;

#warum = "#driver/burstgenerator/SFT400#driver/surgeg#enerator/CWG500#driver/coupler/CWG520";
strings = strsplit(a,"#");
string = strings(y);
path = char(string);
end
