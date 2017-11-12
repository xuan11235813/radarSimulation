function [x, y ,z] = verticalTransfer(x,y,z)

s = sqrt(abs(x)^2 + abs(y)^2 + abs(z)^2);
x = x/s;
y = y/s;
z = z/s;

t = z/sqrt(1-z^2);
x = - t*x *s;
y = - t*y *s;
z = sqrt(1-z^2)*s;
