clear; 
close all; 
clc; 


i = 0:255;
A = i * (2 * pi / 256);

y = round(127.5 * sin(A) + 127.5)

fid = fopen('sine.hex', 'w');

for k = 1:256
    hex_value = dec2hex(y(k), 2);
    fprintf(fid, '%s\n', hex_value);
end
plot(y)