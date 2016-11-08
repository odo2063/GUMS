function pow_set_channel(nrvd,channel)

st=strcat({'INP:NSEL '},{num2str(channel)});
gpib_write(nrvd,'%s',st{1})
%idn='dummy generator'
end
