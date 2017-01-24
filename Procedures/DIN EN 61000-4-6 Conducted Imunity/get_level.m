function level_data = get_level(level_file)

level_read=csvread(level_file)

f_table(1)=data(1,1)

l=2

while f_table(l)<(data(:,end))
	f_table(l)=f_table(l-1)*1.05;
end

level_data=interp1(log10(level_read(:,1)),level_read(:,2),log10(f_table));

end
