function error = init(genBadress,genBdriverpath,genSadress,genSdriverpath,couadress,coudriverpath)

#whos
#type genBadress
#string = strcat({'ls '},{gendriverpath},{'/*.m'})

#funclist=eval(string{1})

#for y=1:length(funclist);
#	funct = strtrim(funclist(y,:))
#	hupp = funct(length(gendriverpath)+2:end-2)
#	autoload(funct(length(gendriverpath)+2:end-2),strcat(pwd,'/',funct))
#end


autoload('genB_init',strcat(pwd,'/',genBdriverpath,'/genB_init.m'))
autoload('genB_setdur',strcat(pwd,'/',genBdriverpath,'/genB_setdur.m'))
autoload('genB_setfreq',strcat(pwd,'/',genBdriverpath,'/genB_setfreq.m'))
autoload('genB_setper',strcat(pwd,'/',genBdriverpath,'/genB_setper.m'))
autoload('genB_setvolt',strcat(pwd,'/',genBdriverpath,'/genB_setvolt.m'))
autoload('genB_start',strcat(pwd,'/',genBdriverpath,'/genB_start.m'))

autoload('genS_init',strcat(pwd,'/',genSdriverpath,'/genS_init.m'))
autoload('genS_setphas',strcat(pwd,'/',genSdriverpath,'/genS_setphas.m'))
autoload('genS_setvolt',strcat(pwd,'/',genSdriverpath,'/genS_setvolt.m'))
autoload('genS_start',strcat(pwd,'/',genSdriverpath,'/genS_start.m'))

autoload('cou_init',strcat(pwd,'/',coudriverpath,'/cou_init.m'))
autoload('cou_set_burst',strcat(pwd,'/',coudriverpath,'/cou_set_burst.m'))
autoload('cou_set_surge',strcat(pwd,'/',coudriverpath,'/cou_set_surge.m'))
autoload('cou_setlineB',strcat(pwd,'/',coudriverpath,'/cou_setlineB.m'))
autoload('cou_setlineS',strcat(pwd,'/',coudriverpath,'/cou_setlineS.m'))

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

genB_init
genB_setdur
genB_setfreq
genB_setper
genB_setvolt
genB_start

genS_init
genS_setphas
genS_setvolt
genS_start

cou_init
cou_set_burst
cou_set_surge
cou_setlineB
cou_setlineS


GenBObj=genB_init(genBadress)
sleep(1)
GenSObj=genS_init(genSadress)
sleep(1)
#setappdata(hMainGui,'GenObj',GenObj);
#pow_init
couObj=cou_init(couadress)
sleep(1)
#setappdata(hMainGui,'PowObj',PowObj);

#fprintf("hello world!!")

#PowObj=pow_init(powadress);
% setappdata(hMainGui,'PowObj',PowObj)

error = 0#funclist
end
