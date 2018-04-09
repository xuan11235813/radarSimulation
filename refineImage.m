function y = refineImage(y)
y(:,:,2) = 255 - y(:,:,1);
