function data = procedure(BVol,genBaddres,genSaddres)#,couaddres)
#BFreq,BDur,BPeriod,SVol,SAng,SNum,SDur,
a = BVol
#b = str2num(BFreq)
#c = BDur
#d = BPeriod
#e = SVol
#f = SAng
#g = str2num(SNum)
#h = SDur
i = genBaddres
j = genSaddres
#k = couaddres
couObj=cou_set_surge(j)
sleep(1)
#if (BVol ~= '')
#	cou_set_burst(couaddres)
#endif

#if (SVol ~= '')
#couObj=cou_set_surge(a)
#sleep(1)
#endif 

#fplot('sin',[-b g])

data = 0#funclist
end
