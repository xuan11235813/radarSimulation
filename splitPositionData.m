function [positionCoordInner, positionCoordOuter] = splitPositionData()

load('positionData.mat');

position = a;
positionCoordOuter = zeros(numel(position)-1,2);
positionCoordInner = zeros(numel(position)-1,2);
outerIndex = 0;
innerIndex = 0;
for i = 2:numel(position)
    string = position(i);
    string = split(string, ',');
    string = string(2:end);
    string = strip(string, 'left', '"');
    string = strip(string, 'right', '"');
    xCoord = str2double(strip(string(2), 'right', 'm'));
    yCoord = str2double(strip(string(3), 'right', 'm'));
    xCoord = (xCoord - 100)/1000;
    yCoord = (yCoord - 100)/1000;
    d = sqrt(xCoord.^2 + yCoord.^2);
    if d >= 0.045
        outerIndex  = outerIndex +1;
        positionCoordOuter(outerIndex,1) = xCoord;
        positionCoordOuter(outerIndex,2) = yCoord;
    else
        innerIndex = innerIndex +1;
        positionCoordInner(innerIndex,1) = xCoord;
        positionCoordInner(innerIndex,2) = yCoord;
    end
end

positionCoordInner = positionCoordInner(1:innerIndex,:);
positionCoordOuter = positionCoordOuter(1:outerIndex,:);
