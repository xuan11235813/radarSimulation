
% get siegen data
[positionCoordInner, positionCoordOuter] = splitPositionData();

% generate disk
disk = zeros(6000,6000,3);
diskLength = 0.135;
modelName = 'conductor2.bmp';
modelLength = 0.006048/sqrt(3) * 19/20;

rotAngles = zeros(numel(positionCoordInner(:,1)),1);
disk = generateDiskModel(disk, diskLength, modelName, modelLength, positionCoordInner,rotAngles);

imwrite(disk, 'siegenDiskInner.png')
disk = zeros(6000,6000,3);
rotAngles = zeros(numel(positionCoordOuter(:,1)),1);
disk = generateDiskModel(disk, diskLength, modelName, modelLength, positionCoordOuter,rotAngles);

imwrite(disk, 'siegenDiskOuter.png')
