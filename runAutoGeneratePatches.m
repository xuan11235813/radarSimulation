disk = zeros(2000,2000,3);
diskLength = 0.02;
modelName = 'conductor1.bmp';
modelLength = 0.006048;
coordinates = [0, -0.0062;
                0, 0.0062;
                -0.0062,0;
                0.0062,0
                ];
rotAngles = [0,0, pi/2, pi/2];
disk = generateDiskModel(disk, diskLength, modelName, modelLength, coordinates,rotAngles);
imshow(disk)

imwrite(disk, 'exampleGen0062R.png')

sim = SimulateModel('exampleGen0062R.png');

sim.startSimulation();