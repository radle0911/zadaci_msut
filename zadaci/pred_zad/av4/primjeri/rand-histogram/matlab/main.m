try
    fclose(fid);
end

close all
clear all
clc

fid = serial('/dev/ttyUSB0','BaudRate',115200, 'InputBufferSize', 4096);
fopen(fid);

N = 1024;
y = zeros(1,N/4);
data = zeros(1,N);
M = 0;    
cdata = 0;
    
for k=1:1000

    fwrite(fid,cdata,'uint8');
    data = fread(fid,N,'uint8');
    k

    g = 1;
    for n=1:(N/4 - 1)
        y(g) = double(data(4*n+1))*256*256*256 + double(data(4*n+2))*256*256+ double(data(4*n+3))*256+ double(data(4*n+4));
        g = g + 1;
    end
    
    M = M + 10240;
    y = y/M; 

    plot(y);
    xlabel('N');
    ylabel('Count');
    axis([0 255 0 max(y) + 0.001]);
    
    pause(0.01);
end




fclose(fid);