disk = zeros(2000,2000,3);
diskLength = 0.03;
modelName = 'conductor1.bmp';
modelLength = 0.006048;
coordinates = [0, -0.002;
                0, 0.002;
                0.008,0;
                -0.006,0];
rotAngles = [0,pi/8, pi/10, pi/6];
disk = generateDiskModel(disk, diskLength, modelName, modelLength, coordinates,rotAngles);
imshow(disk)