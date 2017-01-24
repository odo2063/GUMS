function data = procedure(genBaddres,genSaddres,couaddres,BVol,BFreq,BDur,BPeriod,SVol,SAng,SNum,SDur, B, S, complete, BVStart)

PEN = cellstr(["00";"10";"11";"01"]);
LLL = cellstr(["000";"001";"011";"111";"101";"100";"110";"010"]);
VOL = cellstr(["0.25";"0.5";"1";"2";"4"]);

number = ceil(10/(BPeriod/1000));

if BVol ~= 0									#burst y/n
genB_setdur(genBaddres,BDur)
genB_setfreq(genBaddres,BFreq)
genB_setper(genBaddres,BPeriod)
	if complete ~= 0							#complete? y-
		index = strcmp(VOL, num2str(BVol));		#ende übersetzen
		BVEnd = find (index, 1);
		for v=BVStart:1:BVEnd					#loop vol
			BurstVol=str2num(char(VOL(v)));
			genB_setvolt(genBaddres,BurstVol)
			for l=1:1:complete					#loop coupler settings
				for p=1:1:4
					x = ((l-1)*4)+p;
					comp=strcat(PEN(p),LLL(l));
					B=bin2dec(comp);
					if B ~= 0
						cou_setlineB(couaddres,B)
						for t=1:3
							genB_start(genBaddres,number)
							[dev_null] = system ("Checker.py", "20")
							if OUTPUT == 2
								exit
							endif
						endfor
					endif
				endfor
			endfor
		endfor

	else
		genB_setvolt(genBaddres,BVol)
		cou_setlineB(couaddres,B)
		for t=1:3
			genB_start(genBaddres,number)
			[dev_null,OUTPUT] = python ("Checker.py", "20")
			if OUTPUT == 2
				break
			endif
		endfor
	endif
endif


if SVol ~= 0									#surge y/n
	cou_set_surge(couaddres)
	if complete ~= 0							#complete? y-
		index = strcmp(VOL, num2str(SVol));		#ende übersetzen
		SVEnd = find (index, 1);
		for v=2:1:SVEnd							#loop vol
			SurgeVol=str2num(char(VOL(v)));
			genS_setvolt(genSaddres,SurgeVol)				
			S = 1;
			while S <= 8
				B = 1;							#loop coupler settings
				while B <= 16
					LINE = strcat(num2str(B),num2str(S));
					if B > S
						cou_setlineS(couaddres,B,S)
						for a = 0:90:270
							genS_setphas(genSaddres,a)
							for t=1:10
								sett=a*t;
								genS_start(genSaddres,3)
								[dev_null,OUTPUT] = system ("Checker.py", "2")
								if OUTPUT == 2
									exit
								endif
							endfor
						endfor
					endif
				B=B*2
				end
			S=S*2
			end
		endfor

	else
		genS_setvolt(genSaddres,SVol)
		genS_setphas(genSaddres,SAng)
		cou_setlineS(couaddres,B,S)
		#wait = SDur / SNum
		for t=1:SNum
			genS_start(genSaddres,3)
			[dev_null,OUTPUT] = system ("Checker.py", "2")
				if OUTPUT = 2
					exit
				endif
		endfor
	endif
	cou_set_burst(couaddres)
endif



data = 0;#funclist
end
