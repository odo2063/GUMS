function stirrer_act_deinit()
hMainGui = getappdata(0,'hMainGUI');
obj1 = getappdata(hMainGui,'ActObj');
fclose(obj1);

end
