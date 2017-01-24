function create_report(data)
	cd cal
	[file,path] = uiputfile('caldata.csv','Save Caldata');
	cd ..
	filename = strcat(path,'/',file);
	fid = fopen(filename,'w');


	fprintf(fid,'\r\n');


    fprintf(fid,'Frequency[Hz],Cal value[dB],Gen level[dB�V],Input level[dB�V],Output level[dB�V]\r\n');


	fprintf(fid,'%.4f,%.2f,%.2f,%.2f,%.2f\r\n',data')
	fclose(fid);
end
