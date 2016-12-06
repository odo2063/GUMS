function data = test(y)
n=1;
S = 1;
while S <= 8
	B = 1;							#loop coupler settings
	while B <= 16
		if B ~= S
			x = n;
			bu(x)=B;
			su(x)=S;
			n=n+1;
		endif
	B=B*2;
	endwhile
S=S*2;
endwhile

data = su;#funclist
end
