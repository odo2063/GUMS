function error = init(genadress,gendriverpath,powadress,powdriverpath)

#string = strcat({'ls '},{gendriverpath},{'/*.m'})

#funclist=eval(string{1})

#for y=1:length(funclist);
#	funct = strtrim(funclist(y,:))
#	hupp = funct(length(gendriverpath)+2:end-2)	
#	autoload(funct(length(gendriverpath)+2:end-2),strcat(pwd,'/',funct))
#end

autoload('gen_adjust_amp',strcat(pwd,'/',gendriverpath,'/gen_adjust_amp.m'))
autoload('gen_deinit',strcat(pwd,'/',gendriverpath,'/gen_deinit.m'))
autoload('gen_get_idn',strcat(pwd,'/',gendriverpath,'/gen_get_idn.m'))
autoload('gen_init',strcat(pwd,'/',gendriverpath,'/gen_init.m'))
autoload('gen_init_fast',strcat(pwd,'/',gendriverpath,'/gen_init_fast.m'))
autoload('gen_set_freq',strcat(pwd,'/',gendriverpath,'/gen_set_freq.m'))
autoload('gen_set_level',strcat(pwd,'/',gendriverpath,'/gen_set_level.m'))
autoload('gen_set_level_inc',strcat(pwd,'/',gendriverpath,'/gen_set_level_inc.m'))
autoload('gen_set_mod_depth',strcat(pwd,'/',gendriverpath,'/gen_set_mod_depth.m'))
autoload('gen_set_mod_freq',strcat(pwd,'/',gendriverpath,'/gen_set_mod_freq.m'))
autoload('gen_set_mod_off',strcat(pwd,'/',gendriverpath,'/gen_set_mod_off.m'))
autoload('gen_set_output',strcat(pwd,'/',gendriverpath,'/gen_set_output.m'))

autoload('pow_deinit',strcat(pwd,'/',powdriverpath,'/pow_deinit.m'))
autoload('pow_get_idn',strcat(pwd,'/',powdriverpath,'/pow_get_idn.m'))
autoload('pow_get_value',strcat(pwd,'/',powdriverpath,'/pow_get_value.m'))
autoload('pow_init',strcat(pwd,'/',powdriverpath,'/pow_init.m'))
autoload('pow_init_fast',strcat(pwd,'/',powdriverpath,'/pow_init_fast.m'))
autoload('pow_set_channel',strcat(pwd,'/',powdriverpath,'/pow_set_channel.m'))
#dummy_gen_init(powaddres,genaddres)
#hMainGui = getappdata(0,'hMainGUI');
#genadress = getappdata(hMainGui,'genadress')
#powadress = getappdata(hMainGui,'powadress')
#gendir = getappdata(hMainGui,'gendir')
#powdir = getappdata(hMainGui,'powdir')

#addpath(gendir)
#addpath(powdir)
#genpath = genaddresfile + "/set_freq"
#autoload("set_freq",

#setappdata(hMainGui,'ValueType','DBUV');
gen_adjust_amp
gen_deinit
gen_get_idn
gen_set_freq
gen_set_level
gen_set_level_inc
gen_set_mod_depth
gen_set_mod_freq
gen_set_mod_off
gen_set_output
gen_init
gen_init_fast

pow_deinit
pow_get_idn
pow_get_value
pow_set_channel
pow_init
pow_init_fast



GenObj=gen_init(str2num(genadress))
#setappdata(hMainGui,'GenObj',GenObj);
#pow_init
PowObj=pow_init(str2num(powadress))
#setappdata(hMainGui,'PowObj',PowObj);

#fprintf("hello world!!")

idn = gen_get_idn(GenObj)
idn = pow_get_idn(PowObj)

#PowObj=pow_init(powadress);
display(PowObj)
% setappdata(hMainGui,'PowObj',PowObj)
gpib_close(GenObj)
gpib_close(PowObj)

error = 0#funclist
end
