function [x,y] = findCoord( centerPoint, relativeCoord, heightLength, height, widthLength, width)

% center point is start from left bottom point, with rate
% 

centerX = ceil(centerPoint(1) * width);
centerY = ceil(centerPoint(2) * height);

relativeIndexX = round(relativeCoord(1)/( widthLength/width));
relativeIndexY = round(relativeCoord(2)/( heightLength/height));

refX = centerX + relativeIndexX;
refY = centerY + relativeIndexY;

x = refX;
y = height - refY + 1;

if x <= 0
    x = 0;
end
if x >= width
    x = width;
end

if y<= 0
    y = 0;
end

if y>= height
    y = height;
end