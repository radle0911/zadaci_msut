clear all
M = log10(exp(1))*1000;
M = log10(M);
pwmval = logspace(0,M,64)/log10(exp(1));
plot(pwmval);


for k=1:8:64
    disp(sprintf('%d,',uint32(pwmval(k))))
end
