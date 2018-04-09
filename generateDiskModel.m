function disk = generateDiskModel(disk, diskLength, modelName, modelLength, coordinates,rotAngles)

% disk and model only receive square 

modelImage  = imread(modelName);

[~, widthModel, ~] = size(modelImage);
[heightDisk, widthDisk, ~] = size(disk);

modelPixelLength = modelLength/widthModel;
diskPixelLength = diskLength/widthDisk;

rate = modelPixelLength/diskPixelLength;

modelImage = imresize(modelImage, rate);
for i = 1:numel(rotAngles)
    readyToPaste = refineImage(imrotate(modelImage, rotAngles(i)/pi * 180));
    [x,y] = findCoord( [0.5,0.5], coordinates(i,:), diskLength, heightDisk, diskLength, widthDisk);
    coord = [x, y];
    disk = pasteImage(disk, readyToPaste, coord);
end