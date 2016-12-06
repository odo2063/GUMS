function data = test(a)
PEN = cellstr(["00";"10";"11";"01"]);
LLL = cellstr(["000";"001";"011";"111";"101";"100";"110";"010"]);

for l=1:1:a
	for p=1:1:4
		x = ((l-1)*4)+p;
		copl(x)=strcat(PEN(p),LLL(l));
	endfor
endfor

data = copl;
