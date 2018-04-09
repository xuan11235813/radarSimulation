function img = pasteImage(img, model, coord)

[height, width, ~] = size(model);
biasedX = coord(1) - round(width/2);
biasedY = coord(2) - round(height/2);



capture = img( biasedY : biasedY + height -1, biasedX: biasedX + width - 1, 1);
img(biasedY : biasedY + height -1, biasedX: biasedX + width - 1,  1) = ...
    uint8( capture  + double(model(:,:,1)));
   

img = refineImage(img);