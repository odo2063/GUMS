function idn = act_get_idn()
hMainGui = getappdata(0,'hMainGUI');
obj1 = getappdata(hMainGui,'ActObj');
idn = query(obj1, '*IDN?');
idn=idn(1:end-1);

end