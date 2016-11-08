function idn = pow_get_idn(obj1)

idn = gpib_read(obj1, '*IDN?')
idn=idn(1:end-1)
%idn='dummy generator'
end
